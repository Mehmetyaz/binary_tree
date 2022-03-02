part of 'binary_tree_base.dart';

extension ComparisonOperators on Comparable {
  bool operator >(other) {
    return compareTo(other) == 1;
  }

  bool operator <(other) {
    return compareTo(other) == -1;
  }

  bool operator <=(other) {
    return compareTo(other) < 1;
  }

  bool operator >=(other) {
    return compareTo(other) > -1;
  }
}
