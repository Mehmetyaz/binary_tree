import 'package:binary_tree/binary_tree.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('methods_int', () {
    var tree = BinaryTree([22, 8, 30, 3, 20, 21, 45, 43, 60, 90]);
    test('contains', () {
      expect([
        tree.contains(3),
        tree.contains(21),
        tree.contains(22),
        tree.contains(8),
        tree.contains(90),
      ], isNot(contains(false)));
    });

    test('contains_not', () {
      expect([
        tree.contains(4),
        tree.contains(16),
        tree.contains(23),
        tree.contains(19),
        tree.contains(48),
      ], isNot(contains(true)));
    });

    test('search', () {
      expect([
        tree.search(3),
        tree.search(21),
        tree.search(22),
        tree.search(8),
        tree.search(90),
        tree.search(4),
        tree.search(16),
        tree.search(23),
        tree.search(19),
        tree.search(48),
      ], [
        3,
        21,
        22,
        8,
        90,
        null,
        null,
        null,
        null,
        null
      ]);
    });
  });

  group('methods_custom', () {
    var tree = BinaryTree<Comparable>([22, 8, 30, 3, 20, 21, 45, 43, 60, 90]
        .map((e) => ComparableCustomClass(e))
        .toList());
    test('contains', () {
      expect([
        tree.contains(ComparableCustomClass(3)),
        tree.contains(21),
        tree.contains(ComparableCustomClass(22)),
        tree.contains(8),
        tree.contains(90),
      ], isNot(contains(false)));
    });

    test('contains_not', () {
      expect([
        tree.contains(4),
        tree.contains(16),
        tree.contains(ComparableCustomClass(23)),
        tree.contains(19),
        tree.contains(ComparableCustomClass(48)),
      ], isNot(contains(true)));
    });

    test('search', () {
      expect([
        tree.search(3),
        tree.search(21),
        tree.search(22),
        tree.search(8),
        tree.search(90),
        tree.search(4),
        tree.search(16),
        tree.search(23),
        tree.search(19),
        tree.search(48),
      ], [
        ComparableCustomClass(3),
        ComparableCustomClass(21),
        ComparableCustomClass(22),
        ComparableCustomClass(8),
        ComparableCustomClass(90),
        null,
        null,
        null,
        null,
        null
      ]);
    });
  });
}

class ComparableCustomClass extends Comparable {
  ComparableCustomClass(this.value);

  final int value;

  @override
  bool operator ==(Object other) =>
      other is ComparableCustomClass ? value == other.value : value == (other);

  @override
  int get hashCode => value.hashCode;

  @override
  int compareTo(other) => other is ComparableCustomClass
      ? value.compareTo(other.value)
      : value.compareTo(other as int);
}
