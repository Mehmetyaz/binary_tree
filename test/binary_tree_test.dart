import 'dart:math';

import 'package:binary_tree/binary_tree.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  var i = 0;
  while (i < 1000) {
    testSorted(i.toString());
    testRemove(i.toString());
    i++;
  }
}

void testRemove(String i) {
  test("$i remove", () {
    var l = getListByMultiplier(5, 10000);
    var binaryList = BinaryTree(l);
    var sorted = l.toList();
    sorted.sort((a, b) => a.compareTo(b));

    var i = 0;

    while (i < 500) {
      /// contains
      sorted.remove(i * 100);
      binaryList.remove(i * 100);

      /// not contains
      sorted.remove(i * 100 + 3);
      binaryList.remove(i * 100 + 3);

      i++;
    }

    var binarySorted = binaryList.toList();
    expect(binarySorted, sorted);
    expect(binarySorted.length, sorted.length);
  });
}

List<int> getListByMultiplier(int multiplier, int length) {
  var l = <int>[];
  var i = 0;
  while (i < length) {
    l.add(i * multiplier);
    i++;
  }

  return l;
}

testSorted(String h) {
  test("test - $h", () {
    var l = randomList();
    var binaryList = BinaryTree(l);
    var binarySorted = binaryList.toList();
    var sorted = l.toList();
    sorted.sort((a, b) => a.compareTo(b));
    expect(binarySorted, sorted);
  });
}

Set<int> randomList() {
  var rand = Random();
  var list = <int>{};
  while (list.length < 1000) {
    list.add(rand.nextInt(100000));
  }
  return list;
}
