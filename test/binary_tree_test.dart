import 'dart:math';

import 'package:binary_tree/binary_tree.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  testInt();
  testCustom();
  testIssue7();
}

void testInt() {
  var i = 0;
  while (i < 100) {
    testSorted(i.toString());
    testRemove(i.toString());
    i++;
  }
}

void testCustom() {
  var i = 0;
  while (i < 100) {
    testSortedCustom(i.toString());
    testRemoveCustom(i.toString());
    i++;
  }
}

void testRemove(String i) {
  test('$i remove', () {
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

void testIssue7() {
  test('issue 7', () {
    final tree = BinaryTree<int>([
      15985,
      15977,
      16006,
      4508,
      15982,
      16000,
      16022,
      4500,
      15964,
      15978,
      15984,
      15999,
      16005,
      16019,
      16041,
      15980,
      15983,
      16040
    ]);

    tree.remove(15977);

    expect(tree, hasLength(17));
    expect(tree.toList(), hasLength(17));
    expect(tree.toList(), [
      4500,
      4508,
      15964,
      15978,
      15980,
      15982,
      15983,
      15984,
      15985,
      15999,
      16000,
      16005,
      16006,
      16019,
      16022,
      16040,
      16041
    ]);
  });
}

void testRemoveCustom(String i) {
  test('$i custom remove', () {
    var l = getListByMultiplierCustom(5, 10000);
    var binaryList = BinaryTree(l);
    var sorted = l.toList();
    sorted.sort((a, b) => a.compareTo(b));

    var i = 0;

    while (i < 500) {
      /// contains
      sorted.remove(CustomClass(i * 100));
      binaryList.remove(CustomClass(i * 100));

      /// not contains
      sorted.remove(CustomClass(i * 100 + 3));
      binaryList.remove(CustomClass(i * 100 + 3));

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

List<CustomClass> getListByMultiplierCustom(int multiplier, int length) {
  var l = <CustomClass>[];
  var i = 0;
  while (i < length) {
    l.add(CustomClass(i * multiplier));
    i++;
  }

  return l;
}

void testSorted(String h) {
  test('test - $h', () {
    var l = randomList();
    var binaryList = BinaryTree(l);
    var binarySorted = binaryList.toList();
    var sorted = l.toList();
    sorted.sort((a, b) => a.compareTo(b));
    expect(binarySorted, sorted);
  });
}

void testSortedCustom(String h) {
  test('test - custom - $h', () {
    var l = randomCustom();
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
  while (list.length < 100) {
    list.add(rand.nextInt(100000));
  }
  return list;
}

Set<CustomClass> randomCustom() {
  var rand = Random();
  var list = <CustomClass>{};
  while (list.length < 100) {
    list.add(CustomClass(rand.nextInt(100000)));
  }
  return list;
}

class CustomClass extends Comparable<CustomClass> {
  CustomClass(this.value)
      : values = List.generate(10, (index) => Random().nextInt(10));

  ///
  final int value;

  final List<int> values;

  @override
  bool operator ==(Object other) =>
      other is CustomClass && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  int compareTo(other) => value.compareTo(other.value);
}
