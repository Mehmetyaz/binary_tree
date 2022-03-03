part of 'binary_tree_base.dart';

class Bound<T extends Comparable> {
  Bound({required this.element, required this.equal});

  T element;
  bool equal;

  bool check(T value, bool asc) => asc
      ? equal
          ? element >= value
          : element > value
      : equal
          ? element <= value
          : element < value;
}

class BoundError<T extends Comparable> implements Error {
  BoundError(
      {required this.element, required this.bound, required this.expression});

  static void check<R extends Comparable>(
      {required Bound<R> bound,
      required R element,
      required bool greaterThan,
      required bool equal}) {
    if (equal) {
      if (greaterThan) {
        if (bound.equal) {
          if (!(bound.element >= element)) {
            throw BoundError<R>(
                element: element, bound: bound.element, expression: '<');
          }
        } else {
          if (!(bound.element > element)) {
            throw BoundError(
                element: element, bound: bound.element, expression: '>=');
          }
        }
      } else {
        if (bound.equal) {
          if (!(bound.element <= element)) {
            throw BoundError<R>(
                element: element, bound: bound.element, expression: '>');
          }
        } else {
          if (!(bound.element < element)) {
            throw BoundError(
                element: element, bound: bound.element, expression: '<=');
          }
        }
      }
    } else {
      if (greaterThan) {
        if (!(bound.element > element)) {
          throw BoundError(
              element: element, bound: bound.element, expression: '<=');
        }
      } else {
        if (!(bound.element < element)) {
          throw BoundError(
              element: element, bound: bound.element, expression: '>=');
        }
      }
    }
  }

  T bound;

  T element;

  String expression;

  @override
  String toString() => 'Wrong bound : $bound $expression $element';

  @override
  StackTrace? get stackTrace => StackTrace.current;
}
