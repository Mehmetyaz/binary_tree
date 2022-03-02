import 'package:binary_tree/src/binary_tree_base.dart';

import 'create_csv.dart';

/// scenario
/// even integers (2 * i)
/// length 20 -> N (20 increases)
/// contains -> 10 times even , 10 times odd
///
/// For lists of different lengths, we query remove 20 times.
/// We are sure that 10 of them exist,
/// we are sure that the other 10 do not exist.
/// These 10 numbers are evenly spaced across the list.
/// The other 10 numbers are the existing number + 1.

void main() {
  var tr = <List<int>>[];

  var t = 0;
  while (t < 10) {
    var i = 1;
    var results = <List<int>>[];

    while (i < 1001) {
      var n = i * 20;
      results.add([n, ...testWithLength(n)]);
      if (i % 100 == 0) {
        print('$t $i');
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

  createCsv(tr, 'remove', 'count, list, binary');
}

List<int> testWithLength(int length) {
  var l = getList(length);
  var testNumbers = <int>[];
  var i = 0;
  while (i < 10) {
    var n = i * (length ~/ 20);
    testNumbers.add(n);
    testNumbers.add(n + 1);
    i++;
  }
  var results = <int>[0, 0];
  var binary = BinaryTree(l);
  i = 0;

  while (i < testNumbers.length) {
    var st = Stopwatch()..start();
    l.remove(testNumbers[i]);
    st.stop();
    results[0] += st.elapsedMicroseconds;
    st.reset();

    st.start();
    binary.remove(testNumbers[i]);
    st.stop();
    results[1] += st.elapsedMicroseconds;
    i++;
  }

  return results;
}

List<int> getList(int length) => List.generate(length, (index) => index * 2);
