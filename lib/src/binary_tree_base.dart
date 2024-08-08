import 'dart:collection';

import 'dart:math' as math;

part 'node.dart';

part 'iterator.dart';

part 'comparison_operators.dart';

part 'bound.dart';

/// Self-Balancing Binary Search Tree
/// https://en.wikipedia.org/wiki/Binary_search_tree
class BinaryTree<T extends Comparable> extends IterableBase<T> {
  /// Create Binary Tree
  BinaryTree([Iterable<T>? values]) : super() {
    if (values != null) {
      insertAll(values);
    }
  }

  ///
  int _length = 0;

  TreeNode<T>? _rootNode;

  /// Root node
  TreeNode<T> get root => _rootNode!;

  /// Insert a value
  void insert(T element) {
    _rootNode = _insert(element, _rootNode);
    _length++;
  }

  /// Remove a value if exists
  void remove(T element) {
    if (_rootNode == null) return;
    _rootNode = _remove(element, _rootNode);
  }

  int _h(TreeNode<T>? n) => n == null ? -1 : n.height;

  TreeNode<T> _balance(TreeNode<T> t) {
    while (_h(t.left) - _h(t.right) > 1) {
      t = _shiftRight(t);
    }
    while (_h(t.right) - _h(t.left) > 1) {
      t = _shiftLeft(t);
    }
    return t;
  }

  ///
  TreeNode<T>? _removeMax(
      TreeNode<T>? parent, TreeNode<T> n, void Function(T) onMax) {
    TreeNode<T>? node = n;
    if (n.right == null) {
      onMax(n.data);
      _length--;
      node = null;
    } else {
      node.right = _removeMax(n, n.right!, onMax);
    }

    node?._setH();
    if (node != null) {
      node = _balance(node);
    }
    return node;
  }

  ///
  TreeNode<T>? _removeMin(
      TreeNode<T>? parent, TreeNode<T> n, void Function(T) onMin) {
    TreeNode<T>? node = n;
    if (n.left == null) {
      onMin(n.data);
      node = null;
      _length--;
    } else {
      node.left = _removeMin(n, n.left!, onMin);
    }

    node?._setH();
    if (node != null) {
      node = _balance(node);
    }
    return node;
  }

  ///
  TreeNode<T>? _remove(T element, TreeNode<T>? node) {
    if (node == null) return null;

    if (identical(node.data, element) || node.data == element) {
      /// remove this
      if (node.isEnd) {
        _length--;
        return null;
      } else {
        var hl = _h(node.left);
        var hr = _h(node.right);
        if (hl > hr) {
          T? leftMax;
          var r = _removeMax(node, node.left!, (p0) {
            leftMax = p0;
          });
          node.left = r;
          node.data = leftMax!;
        } else {
          T? rightMin;
          var r = _removeMin(node, node.right!, (p0) {
            rightMin = p0;
          });
          node.right = r;
          node.data = rightMin!;
        }
      }
    } else if (node.data < element) {
      node.right = _remove(element, node.right);
    } else if (node.data > element) {
      node.left = _remove(element, node.left);
    }
    node = _balance(node);
    return node;
  }

  TreeNode<T> _insert(T element, TreeNode<T>? t) {
    if (t == null) {
      t = TreeNode(element);
    } else if (element < t.data) {
      t.left = _insert(element, t.left);

      if (_h(t.left) - _h(t.right) == 2) {
        t = _shiftRight(t);
      }
    } else if (element > t.data) {
      t.right = _insert(element, t.right);
      if (_h(t.right) - _h(t.left) == 2) {
        t = _shiftLeft(t);
      }
    }
    t.height = math.max(_h(t.right), _h(t.left)) + 1;
    return t;
  }

  TreeNode<T> _shiftLeft(TreeNode<T> k1) {
    var k2 = k1.right;
    k1.right = k2?.left;
    k2?.left = k1;
    k1.height = math.max(_h(k1.left), _h(k1.right)) + 1;
    k2?.height = math.max(_h(k2.right), k1.height) + 1;
    return k2!;
  }

  TreeNode<T> _shiftRight(TreeNode<T> k2) {
    var k1 = k2.left;
    k2.left = k1?.right;
    k1?.right = k2;
    k2.height = math.max(_h(k2.left), _h(k2.right)) + 1;
    k1?.height = math.max(_h(k1.left), k2.height) + 1;
    return k1!;
  }

  /// Minimum value
  T get min => first;

  /// Maximum value
  T get max => last;

  ///
  @override
  T get first {
    if (_rootNode == null) {
      throw ArgumentError('No Element');
    }
    var node = _rootNode;
    while (node?.left != null) {
      node = node?.left;
    }
    return node!.data;
  }

  /// Last value, is also maximum
  @override
  T get last {
    if (_rootNode == null) {
      throw ArgumentError('No Element');
    }
    var node = _rootNode;
    while (node?.right != null) {
      node = node?.right;
    }
    return node!.data;
  }

  ///
  @override
  int get length => _length;

  @override
  bool get isEmpty => _rootNode == null;

  @override
  bool get isNotEmpty => !isEmpty;

  /// Insert all values
  void insertAll(Iterable<T> elements) {
    for (var i in elements) {
      insert(i);
    }
  }

  /// Iterator between the range
  /// Range starting point is [element]. If the range can contains [element],
  /// [equal] must be true.
  ///
  /// [greaterThan] must be true to get greater than this starting point.
  ///
  /// if greaterThan, iterator sorted ascending, else sorted descending.
  ///
  /// [bound] the end point of the range
  BinaryTreeRangeIterator<T> iteratorFrom(T element,
          {bool equal = false, bool greaterThan = true, Bound<T>? bound}) =>
      bound != null
          ? BinaryTreeRangeIteratorWithBound.from(this, element,
              equal: equal, greaterThan: greaterThan, bound: bound)
          : BinaryTreeRangeIterator.from(this, element,
              equal: equal, greaterThan: greaterThan);

  @override
  BinaryTreeIterator<T> get iterator => BinaryTreeIterator(this);

  /// To list between the range
  /// Range starting point is [element]. If the range can contains [element],
  /// [equal] must be true.
  ///
  /// [greaterThan] must be true to get greater than this starting point.
  ///
  /// if greaterThan, list sorted ascending, else sorted descending.
  ///
  /// [bound] the end point of the range
  List<T> toListFrom(T element,
      {bool equal = false, bool greaterThan = true, Bound<T>? bound}) {
    var it = iteratorFrom(element,
        equal: equal, greaterThan: greaterThan, bound: bound);
    var l = <T>[];
    while (it.moveNext()) {
      l.add(it.current);
    }
    return l;
  }

  /// List of values greater than [element]
  /// return orderly ascending
  List<T> greaterThan(T element, [Bound<T>? bound]) =>
      toListFrom(element, greaterThan: true, bound: bound);

  /// List of values greater or equal than [element]
  /// return orderly ascending
  List<T> greaterThanOrEqual(T element, [Bound<T>? bound]) =>
      toListFrom(element, equal: true, greaterThan: true);

  /// List of values less than [element]
  /// return orderly descending
  List<T> lessThan(T element, [Bound<T>? bound]) =>
      toListFrom(element, greaterThan: false, bound: bound);

  /// List of values less than or equal [element]
  /// return orderly descending
  List<T> lessThanOrEqual(T element, [Bound<T>? bound]) =>
      toListFrom(element, equal: true, greaterThan: false, bound: bound);

  @override
  bool any(bool Function(T element) test) {
    var it = iterator;

    while (it.moveNext()) {
      if (test(it.current)) {
        return true;
      }
    }
    return false;
  }

  void clear() {
    _rootNode = null;
  }

  /// Search element
  /// If element contains returns element,
  /// else returns null.
  ///
  /// E.g use case:
  ///
  /// class MyComparable extends Comparable<int> {}
  ///
  /// MyComparable? found = search(15);
  T? search(Object? element) =>
      element == null ? null : (_rootNode?._search(element));

  @override
  bool contains(Object? element) {
    if (element is! T) return false;
    return _rootNode?._contains(element) ?? false;
  }
}
