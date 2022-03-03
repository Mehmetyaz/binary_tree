part of 'binary_tree_base.dart';

/// Tree Node. Each node have data.
/// May be have left and right
class TreeNode<T extends Comparable> {
  /// Create with data
  TreeNode(this.data);

  @override
  String toString() =>
      '${left?.data} - $data - ${right?.data}    ------ h: $height';

  /// is leaf or is end.
  /// So left and right null.
  bool get isEnd => left == null && right == null;

  /// Holt data
  T data;

  /// deep
  int height = 0;

  /// Left node
  TreeNode<T>? left;

  /// Left node
  TreeNode<T>? right;

  int _h(TreeNode<T>? n) => n == null ? -1 : n.height;

  void _setH() {
    height = math.max(_h(left), _h(right)) + 1;
  }

  bool _contains(T element) {
    if (data == element) return true;
    if (element > data) {
      return right?._contains(element) ?? false;
    } else if (element < data) {
      return left?._contains(element) ?? false;
    } else {
      return false;
    }
  }
}
