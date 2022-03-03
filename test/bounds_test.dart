import 'dart:math';

import 'package:binary_tree/src/binary_tree_base.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  for (var i = 0; i < 500; i++) {
    var l = randomList();
    test('$i', () {
      expect(getSubWithList(l), getSubWithBinary(l));
    });
  }
}

List<int> getSubWithBinary(List<int> l) {
  var b = BinaryTree(l);
  return b.toListFrom(3000,
      equal: false,
      greaterThan: true,
      bound: Bound(element: 7000, equal: false));
}

List<int> getSubWithList(List<int> l) =>
    l.where((element) => element > 3000 && element < 7000).toList()..sort();

List<int> randomList() {
  var rand = Random();
  var list = <int>{};
  while (list.length < 1000) {
    list.add(rand.nextInt(10000));
  }
  return list.toList();
}
