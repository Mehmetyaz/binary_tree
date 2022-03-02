part of 'binary_tree_base.dart';

class BinaryTreeIterator<T extends Comparable> extends Iterator<T> {
  ///
  BinaryTreeIterator(this._tree) : _length = _tree._length;

  final BinaryTree<T> _tree;
  final int _length;

  ///
  IteratorNode<T>? _currentNode;

  @override
  T get current => _currentNode!.treeNode.data;

  @override
  bool moveNext() {
    if (_length != _tree._length) {
      throw ConcurrentModificationError();
    }
    while (true) {
      if (_currentNode == null) {
        if (_tree._rootNode == null) return false;
        var _c = IteratorNode(_tree._rootNode!, null);
        while (_c.treeNode.left != null) {
          _c = IteratorNode(_c.treeNode.left!, _c);
        }
        _currentNode = _c;
        _currentNode?.currentIterated = true;
        return true;
      }

      if (_currentNode!.currentIterated) {
        if (_currentNode!.treeNode.right != null) {
          if (_currentNode!.rightIterated) {
            _currentNode = _currentNode!.parent;
            if (_currentNode == null) return false;
          } else {
            var _c = IteratorNode(_currentNode!.treeNode.right!, _currentNode);
            _currentNode!.rightIterated = true;
            while (_c.treeNode.left != null) {
              _c = IteratorNode(_c.treeNode.left!, _c);
            }
            _currentNode = _c;
            _currentNode?.currentIterated = true;
            return true;
          }
        } else {
          _currentNode = _currentNode!.parent;
          if (_currentNode == null) return false;
        }
      } else {
        _currentNode!.currentIterated = true;
        return true;
      }
    }
  }

  bool moveBack() {
    if (_length != _tree._length) {
      throw ConcurrentModificationError();
    }
    while (true) {
      if (_currentNode == null) {
        if (_tree._rootNode == null) return false;
        var _c = IteratorNode(_tree._rootNode!, null);
        while (_c.treeNode.right != null) {
          _c = IteratorNode(_c.treeNode.right!, _c);
        }
        _currentNode = _c;
        _currentNode?.currentIterated = true;
        return true;
      }

      if (_currentNode!.currentIterated) {
        if (_currentNode!.treeNode.left != null) {
          if (_currentNode!.rightIterated) {
            _currentNode = _currentNode!.parent;
            if (_currentNode == null) return false;
          } else {
            var _c = IteratorNode(_currentNode!.treeNode.left!, _currentNode);
            _currentNode!.rightIterated = true;
            while (_c.treeNode.right != null) {
              _c = IteratorNode(_c.treeNode.right!, _c);
            }
            _currentNode = _c;
            _currentNode?.currentIterated = true;
            return true;
          }
        } else {
          _currentNode = _currentNode!.parent;
          if (_currentNode == null) return false;
        }
      } else {
        _currentNode!.currentIterated = true;
        return true;
      }
    }
  }
}

class BinaryTreeRangeIterator<T extends Comparable> extends Iterator<T> {
  BinaryTreeRangeIterator.from(this._tree, this.element,
      {required this.equal, required this.greaterThen})
      : _length = _tree._length;

  final T element;

  final bool equal;

  final bool greaterThen;

  final BinaryTree<T> _tree;
  final int _length;

  ///
  TreeNode<T>? _currentNode;

  @override
  T get current => _currentNode!.data;

  RangeIteratorNode<T>? _rootNode;

  @override
  bool moveNext() {
    if (_length != _tree.length) {
      throw ConcurrentModificationError();
    }

    if (_rootNode == null) {
      if (_tree._rootNode == null) return false;
      _rootNode = RangeIteratorNode(_tree.root, null, this);
      _rootNode!._setCurrent();
    }

    var n = greaterThen ? _rootNode!.moveNext() : _rootNode!.moveBack();
    if (n == null) return false;
    _currentNode = n;
    return true;
  }
}

class RangeIteratorNode<T extends Comparable> extends IteratorNode<T> {
  RangeIteratorNode(
      TreeNode<T> treeNode, IteratorNode<T>? parent, this._iterator)
      : super(treeNode, parent);

  final BinaryTreeRangeIterator<T> _iterator;

  RangeIteratorNode<T>? _left, _right;

  /// return iterated
  bool _setCurrent() {
    if (_iterator.element > treeNode.data) {
      if (_iterator.greaterThen) {
        leftIterated = true;
        currentIterated = true;
      }
      if (treeNode.right != null) {
        _right = RangeIteratorNode(treeNode.right!, this, _iterator);
        rightIterated = _right!._setCurrent();
      }
    } else if (_iterator.element < treeNode.data) {
      if (!_iterator.greaterThen) {
        rightIterated = true;
        currentIterated = true;
      }
      if (treeNode.left != null) {
        _left = RangeIteratorNode(treeNode.left!, this, _iterator);
        leftIterated = _left!._setCurrent();
      }
    } else {
      /// equal
      if (_iterator.greaterThen) {
        leftIterated = true;
        if (!_iterator.equal) {
          currentIterated = true;
        }
        if (treeNode.right == null) {
          rightIterated = true;
        }
      } else {
        rightIterated = true;
        if (!_iterator.equal) {
          currentIterated = true;
        }
        if (treeNode.left == null) {
          leftIterated = true;
        }
      }
    }

    return leftIterated && rightIterated && currentIterated;
  }

  ///
  TreeNode<T>? moveNext() {
    if (treeNode.left != null && !leftIterated) {
      _left ??= RangeIteratorNode(treeNode.left!, this, _iterator);
      var res = _left!.moveNext();
      if (res != null) {
        return res;
      } else {
        leftIterated = true;
      }
    }
    if (!currentIterated) {
      currentIterated = true;
      return treeNode;
    }
    if (treeNode.right != null && !rightIterated) {
      _right ??= RangeIteratorNode(treeNode.right!, this, _iterator);
      var res = _right!.moveNext();
      if (res != null) {
        return res;
      } else {
        rightIterated = true;
      }
    }
    return null;
  }

  ///
  TreeNode<T>? moveBack() {
    if (treeNode.right != null && !rightIterated) {
      _right ??= RangeIteratorNode(treeNode.right!, this, _iterator);
      var res = _right!.moveBack();
      if (res != null) {
        return res;
      } else {
        rightIterated = true;
      }
    }
    if (!currentIterated) {
      currentIterated = true;
      return treeNode;
    }
    if (treeNode.left != null && !leftIterated) {
      _left ??= RangeIteratorNode(treeNode.left!, this, _iterator);
      var res = _left!.moveBack();
      if (res != null) {
        return res;
      } else {
        leftIterated = true;
      }
    }
    return null;
  }
}

class IteratorNode<T extends Comparable> {
  IteratorNode(this.treeNode, this.parent);

  TreeNode<T> treeNode;

  IteratorNode<T>? parent;

  bool currentIterated = false;

  bool rightIterated = false;

  bool leftIterated = false;

  ///
  @override
  String toString() {
    return ("NODE: ${parent?.treeNode.data}"
        " -- $treeNode --  "
        "$leftIterated $currentIterated"
        " $rightIterated");
  }
}
