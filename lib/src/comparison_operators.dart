part of 'binary_tree_base.dart';

extension ComparisonOperators on Comparable {
  bool operator >(Comparable other) => compareTo(other) == 1;

  bool operator <(Comparable other) => compareTo(other) == -1;

  bool operator <=(Comparable other) => compareTo(other) < 1;

  bool operator >=(Comparable other) => compareTo(other) > -1;
}
