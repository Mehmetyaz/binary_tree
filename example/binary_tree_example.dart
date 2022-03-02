import 'dart:math';

import 'package:binary_tree/binary_tree.dart';

void main() {
  //
  var b = BinaryTree([10, 8, 16, 4, 9, 13, 25, 2, 6, 12, 26, 14, 18]);

  //print(b.root);
  // print(b.root);
  //var it = b.iteratorTo(8, asc: false, equal: true);
  // var it = b.iteratorFrom(7 ,greaterThen: true,equal: true);
  // // it.moveNext();
  // print(it.current);
  // it.printH();
  //
  print("AAAAAAAAAAAAAAAAAAA");
  //var it = b.iterator;

  b.toListFrom(8,
      equal: false,
      greaterThen: false,
      bound: Bound(element: 8, equal: false));

  // while (it.moveNext()) {
  //   // if (!a) {
  //   //   it.printH();
  //   //   a = true;
  //   // }
  //   // if (it.current == 13) {
  //   //   it.printH();
  //   // }
  //   print(it.current);
  //   // it.printH();
  //   // print("\n\n\n\n");
  // }

  return;

  //
  // var n = it.currentIteratorNode;
  //
  //
  //
  // var l = [];
  //
  // while(n != null) {
  //   l.add(n);
  //   n = n.parent;
  // }
  //
  //
  // print(l.reversed.join(" \n"));

  // print(sortWithBinary(l));
  // print(sortWithList(l));

  // print(tryOne());
  // print(tryOne());
  // print(tryOne());
  // print(tryOne());
  // print(tryOne());
  //
  // return;

  // var total = [0, 0];
  //
  // var i = 0;
  //
  // List<int> last = [0, 0];
  // while (i < 1001) {
  //   var res = tryOne();
  //
  //   if (i != 0) {
  //     total[0] += res[0];
  //     total[1] += res[1];
  //     if (i % 10 == 0) {
  //       print("$i ${[total[0] - last[0], total[1] - last[1]]} $total");
  //       last[0] = total[0];
  //       last[1] = total[1];
  //     }
  //   }
  //   i++;
  // }
  //
  // print(total);

  // var b = BinaryTree([22, 8, 30, 3, 20, 21, 45, 43, 60, 90], asc: false);
  //
  // print(b.min);
  // print(b.max);
  //
  // // var it = b.iteratorTo(90);
  // // it.printH();
  // // while (it.moveBack()) {
  // //   print(it.current);
  // // }
}

List<int> tryOneRemove() {
  var l = getListByMultiplier(5, 10000);
  return [removeWithBinary(l), removeWithList(l)];
}

int removeWithBinary(List<int> l) {
  var t = BinaryTree<int>(l);
  var stopW = Stopwatch()..start();
  var i = 0;
  while (i < 500) {
    t.remove(i * 100);
    t.remove(i * 100 + 3);
    i++;
  }
  stopW.stop();
  return stopW.elapsedMilliseconds;
}

int removeWithList(List<int> l) {
  var stopW = Stopwatch()..start();
  var i = 0;
  while (i < 500) {
    l.remove(i * 100);
    l.remove(i * 100 + 3);
    i++;
  }
  stopW.stop();
  return stopW.elapsedMilliseconds;
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

List<int> tryOne() {
  var l = randomList()..add(10000 ~/ 2);
  return [sortWithBinary(l), sortWithList(l)];
}

int sortWithBinary(List<int> l) {
  var t = BinaryTree<int>(
    l,
  );
  var stopW = Stopwatch()..start();
  t.contains(10000000 ~/ 2);
  t.contains(-1000000);
  stopW.stop();
  return stopW.elapsedMicroseconds;
}

int sortWithList(List<int> l) {
  l.sort();

  var stopW = Stopwatch()..start();
  l.indexOf(10000000 ~/ 2);
  l.indexOf(-1000000);
  stopW.stop();
  return stopW.elapsedMicroseconds;
}

List<int> randomList() {
  var rand = Random();
  var list = <int>{};
  var i = 0;
  while (i < 100000) {
    list.add(rand.nextInt(10000000));
    i++;
  }
  return list.toList();
}
