part of 'binary_tree_base.dart';

extension ComparisonOperators<T> on Comparable<T> {
  bool operator >(T other) => compareTo(other) > 0;

  bool operator <(T other) => compareTo(other) < 0;

  bool operator <=(T other) => compareTo(other) <= 0;

  bool operator >=(T other) => compareTo(other) >= 0;
}
