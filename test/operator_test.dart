


import 'package:binary_tree/binary_tree.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {


  group("operations", (){
    test("contains", (){
      var b = BinaryTree([22,8,30,3,20,21,45,43,60,90]);

      expect(b.contains(8), true);
      expect(b.contains(32), false);
      expect(b.contains(60), true);
    });
  });



}