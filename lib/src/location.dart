part of 'binary_tree_base.dart';

enum _LocationEnum {
  right,
  left,
}

const _LocationEnum right = _LocationEnum.right;
const _LocationEnum left = _LocationEnum.left;

class TreeLocation {
  TreeLocation(this.location);

  final List<_LocationEnum> location;


  List<TreeNode<T>> getWithAncestors<T extends Comparable>(BinaryTree<T> tree) {
    if (tree._rootNode == null) {
      throw ArgumentError("No Element");
    }
    var l = <TreeNode<T>>[];
    var n = tree._rootNode;
    l.add(n!);
    for (var loc in location) {
      var nn = loc == left ? n?.left : n?.right;
      if (nn == null) {
        throw ArgumentError("No Element at specified location");
      }
      n = nn;
      l.add(n);
    }
    return l;
  }

  TreeNode<T> get<T extends Comparable>(BinaryTree<T> tree) {
    if (tree._rootNode == null) {
      throw ArgumentError("No Element");
    }
    var n = tree._rootNode;
    for (var loc in location) {
      var nn = loc == left ? n?.left : n?.right;
      if (nn == null) {
        throw ArgumentError("No Element at specified location");
      }
      n = nn;
    }
    return n!;
  }
}
