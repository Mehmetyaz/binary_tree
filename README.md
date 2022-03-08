Self-Balancing Binary Search Tree for Dart. BST is implemented as Iterable. There are many operations such as
greaterThan, lessThanOrEqual (create sublist), max , min etc.

## Features

````dart
void main() {
  final myNumbers = BinaryTree([10, 8, 16, 4, 9, 13, 25, 2, 6, 12, 26, 14, 18]);
}
````

Binary tree stores values as a binary search tree.<br>
For more information : [Binary Search Tree](https://en.wikipedia.org/wiki/Binary_search_tree).

A Self-Balancing AVL type tree is used, which balances the depth of the nodes.<br>
For more
information : [Self Balancing Binary Search Tree](https://en.wikipedia.org/wiki/Self-balancing_binary_search_tree)
, [AVL Tree](https://en.wikipedia.org/wiki/AVL_tree).

![img.png](https://github.com/Mehmetyaz/binary_tree/blob/master/benchmark/charts/chart.png)

## Usage

### Use Case

You can see if you need it by looking at the benchmarks given below. It is generally advantageous in keeping long and
sorted datasets. Its advantage is not noticeable on short datasets.

Benchmark [scenarios](https://github.com/Mehmetyaz/binary_tree/tree/master/benchmark)

![img_3.png](https://github.com/Mehmetyaz/binary_tree/blob/master/benchmark/charts/contains.png)
![img_1.png](https://github.com/Mehmetyaz/binary_tree/blob/master/benchmark/charts/insert2.png)
![img_2.png](https://github.com/Mehmetyaz/binary_tree/blob/master/benchmark/charts/remove.png)

### Type

Binary Tree objects must be ``Comparable``

All of `num` , `String` , ``Duration`` etc. are `Comparable`.

You can define your objects as ``Comparable``.

[``Comparable`` Documentation](https://api.flutter.dev/flutter/dart-core/Comparable-class.html)

````dart
void main() {
  final myLetters = BinaryTree<String>(["a", "c", "b"]);
  final myDates = BinaryTree<DateTime>([DateTime.now()]);
}
````

### Basic operations

```dart
void main() {
  final myNumbers = BinaryTree([ /*initial*/
  ]);
  myNumbers.insert(value);
  myNumbers.remove(value);
  myNumbers.contains(value);
}
```

### Iterator

You can create an ``Iterator`` by "startsWith" or "endsWith" given element.

````dart
f() {
  final myNumbers = BinaryTree([10, 8, 16, 4, 9, 13, 25, 2, 6, 12, 26, 14, 18]);
  final iterator = myNumbers.iteratorFrom(8, greaterThan: true, equal: false); // defaults
  while (iterator.moveNext()) {
    print(iterator.current); // 9 , 10 ... 26
  }
}
````

You can also define bounds

````dart
f() {
  final myNumbers = BinaryTree([10, 8, 16, 4, 9, 13, 25, 2, 6, 12, 26, 14, 18]);
  final iterator = myNumbers.iteratorFrom(8, bound: Bound(13, equal: true));
  while (iterator.moveNext()) {
    print(iterator.current); // 9 , 10 ... 13
  }
}
````

### toList

You can create new lists using range iterators.

````dart
f() {
  final myNumbers = BinaryTree([10, 8, 16, 4, 9, 13, 25, 2, 6, 12, 26, 14, 18]);

  myNumbers.lessThan(16);

  /// 14 , 13 , ... 2
  myNumbers.lessThanOrEqual(16);

  /// 16 , 14 , 13 , ... 2
  myNumbers.greaterThan(16);

  ///  25 , 26
  myNumbers.greaterThanOrEqual(16);

  /// 16 , 25 , 26

  /// custom bound
  myNumbers.listFrom(16, bound: Bound(13, equal: true));

  /// 16 , 14 , 13

}
````
