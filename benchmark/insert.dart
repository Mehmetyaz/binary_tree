import 'dart:math';

import 'package:binary_tree/binary_tree.dart';

import 'create_csv.dart';

/// scenario
/// random integers (0 - 1B)
/// length 20 -> 1M (20 increases)
/// insert and keep order
///
/// scenario 1
/// insert and sort
///
/// scenario 2
/// find correct index and insert

void main() {
  var tr = <List<int>>[];

  var t = 0;
  while (t < 300) {
    var i = 1;
    var results = <List<int>>[];

    while (i < 201) {
      var n = i * 20;
      results.add([n, ...testWithLength(n)]);
      if (i % 100 == 0) {
        print("$t $i");
      }
      i++;
    }
    if (t == 0) {
      tr = results;
    } else {
      var ii = 0;
      while (ii < results.length) {
        tr[ii][0] = ((tr[ii][0] * t) + results[ii][0]) ~/ (t + 1);
        tr[ii][1] = ((tr[ii][1] * t) + results[ii][1]) ~/ (t + 1);
        ii++;
      }
    }
    t++;
  }

  createCsv(tr, "insert_2", "count, list, binary");
}

List<int> testWithLength(int length) {
  var l = getList(length);

  var results = <int>[0, 0];
  var binary = BinaryTree<int>([]);
  var list = <int>[];
  var i = 0;
  while (i < length) {
    results[0] += addWith2(list, l[i]);
    var st = Stopwatch()..start();
    binary.insert(l[i]);
    st.stop();
    results[1] += st.elapsedMicroseconds;
    i++;
  }

  return results;
}

int addWith2(List<int> l, int e) {
  var st = Stopwatch()..start();

  /// [0 , 4 , 9]
  /// 5
  var i = 0;
  while (i < l.length) {
    if (e < l[i]) {
      break;
    }
    i++;
  }

  l.insert(i, e);
  st.stop();
  return st.elapsedMicroseconds;
}

int addWith1(List<int> l, int e) {
  var st = Stopwatch()..start();

  l.add(e);
  l.sort();

  st.stop();
  return st.elapsedMicroseconds;
}

List<int> getList(int length) {
  var r = Random();
  return List.generate(length, (index) => r.nextInt(1000000000));
}
