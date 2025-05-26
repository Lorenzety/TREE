import 'binary.dart';

void main() {
    BinaryTree Btree = BinaryTree();
    Btree.root = Node(1);
    Btree.root!.left = Node(2);
    Btree.root!.right = Node(3);
    Btree.root!.left!.left = Node(4);

  print("preOrder traversal binary tree");
  Btree.PreOrder(Btree.root);

  print("");
  print("InOrder traversal binarry tree");
  Btree.InOrder(Btree.root);

  print("");
  print("PostOrder traversal binarry tree");
  Btree.PostOrder(Btree.root);
}
