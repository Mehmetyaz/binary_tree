part of 'binary_tree_base.dart';

class TreeNode<T extends Comparable> {
  TreeNode(this.data);

  @override
  String toString() {
    return "${left?.data} - $data - ${right?.data}    ------ h: $height";
  }

  bool get isEnd => left == null && right == null;

  T data;
  int height = 0;
  TreeNode<T>? left;
  TreeNode<T>? right;

  int _h(TreeNode<T>? n) {
    return n == null ? -1 : n.height;
  }

  void _setH(){
    height = math.max(_h(left), _h(right)) + 1;
  }

  bool add(T element) {
    var c = data.compareTo(element);
    if (c == (-1)) {
      if (right == null) {
        right = TreeNode(element);
        return true;
      } else {
        return right!.add(element);
      }
    } else if (c == ( 1)) {
      if (left == null) {
        left = TreeNode(element);
        return true;
      } else {
        return left!.add(element);
      }
    } else {
      return false;
    }
  }

  bool contains(T element) {
    if (data == element) return true;
    if (element > data) {
      return right?.contains(element) ?? false;
    } else if (element < data) {
      return left?.contains(element) ?? false;
    } else {
      return false;
    }
  }







}
