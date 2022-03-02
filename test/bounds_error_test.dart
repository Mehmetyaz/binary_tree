import 'package:binary_tree/binary_tree.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  var binaryTree = BinaryTree([10, 8, 16, 4, 9, 13, 25, 2, 6, 12, 26, 14, 18]);
  group('list gt', () {
    test('lt', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: false,
            greaterThen: true,
            bound: Bound(element: 7, equal: false));
      }, throwsA(isA<BoundError>()));
    });
    test('lte', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: false,
            greaterThen: true,
            bound: Bound(element: 7, equal: true));
      }, throwsA(isA<BoundError>()));
    });

    test('e', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: false,
            greaterThen: true,
            bound: Bound(element: 8, equal: false));
      }, throwsA(isA<BoundError>()));
    });

    test('ee', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: false,
            greaterThen: true,
            bound: Bound(element: 8, equal: true));
      }, throwsA(isA<BoundError>()));
    });

    test('gt', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: false,
            greaterThen: true,
            bound: Bound(element: 10, equal: false));
      }, returnsNormally);
    });
    test('gte', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: false,
            greaterThen: true,
            bound: Bound(element: 10, equal: true));
      }, returnsNormally);
    });
  });

  group('list gte', () {
    test('lt', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: true,
            greaterThen: true,
            bound: Bound(element: 7, equal: false));
      }, throwsA(isA<BoundError>()));
    });
    test('lte', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: true,
            greaterThen: true,
            bound: Bound(element: 7, equal: true));
      }, throwsA(isA<BoundError>()));
    });

    test('e', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: true,
            greaterThen: true,
            bound: Bound(element: 8, equal: false));
      }, throwsA(isA<BoundError>()));
    });

    test('ee', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: true,
            greaterThen: true,
            bound: Bound(element: 8, equal: true));
      }, returnsNormally);
    });

    test('gt', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: true,
            greaterThen: true,
            bound: Bound(element: 10, equal: false));
      }, returnsNormally);
    });
    test('gte', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: true,
            greaterThen: true,
            bound: Bound(element: 10, equal: true));
      }, returnsNormally);
    });
  });

  group('list lt', () {
    test('lt', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: false,
            greaterThen: false,
            bound: Bound(element: 7, equal: false));
      }, returnsNormally);
    });
    test('lte', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: false,
            greaterThen: false,
            bound: Bound(element: 7, equal: true));
      }, returnsNormally);
    });

    test('e', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: false,
            greaterThen: false,
            bound: Bound(element: 8, equal: false));
      }, throwsA(isA<BoundError>()));
    });

    test('ee', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: false,
            greaterThen: false,
            bound: Bound(element: 8, equal: true));
      }, throwsA(isA<BoundError>()));
    });

    test('gt', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: false,
            greaterThen: false,
            bound: Bound(element: 10, equal: false));
      }, throwsA(isA<BoundError>()));
    });
    test('gte', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: false,
            greaterThen: false,
            bound: Bound(element: 10, equal: true));
      }, throwsA(isA<BoundError>()));
    });
  });

  group('list lte', () {
    test('lt', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: true,
            greaterThen: false,
            bound: Bound(element: 7, equal: false));
      }, returnsNormally);
    });
    test('lte', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: true,
            greaterThen: false,
            bound: Bound(element: 7, equal: true));
      }, returnsNormally);
    });

    test('e', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: true,
            greaterThen: false,
            bound: Bound(element: 8, equal: false));
      }, throwsA(isA<BoundError>()));
    });

    test('ee', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: true,
            greaterThen: false,
            bound: Bound(element: 8, equal: true));
      }, returnsNormally);
    });

    test('gt', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: true,
            greaterThen: false,
            bound: Bound(element: 10, equal: false));
      }, throwsA(isA<BoundError>()));
    });
    test('gte', () {
      expect(() {
        binaryTree.toListFrom(8,
            equal: true,
            greaterThen: false,
            bound: Bound(element: 10, equal: true));
      }, throwsA(isA<BoundError>()));
    });
  });
}
