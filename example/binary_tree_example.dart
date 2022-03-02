import 'package:binary_tree/binary_tree.dart';

void main() {
  var b = BinaryTree([10, 8, 16, 4, 9, 13, 25, 2, 6, 12, 14, 18]);

  b.insert(26);
  b.insert(27);
  b.remove(27);

  print(b.toListFrom(8, equal: false, greaterThen: true));

  return;
}
