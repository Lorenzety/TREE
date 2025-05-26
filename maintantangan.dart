import 'tantangan.dart';

void main() {
  BinaryTree tree = BinaryTree();

  tree.insertNodeLevelOrder(50);
  tree.insertNodeLevelOrder(true);
  tree.insertNodeLevelOrder(48);
  tree.insertNodeLevelOrder('A');
  tree.insertNodeLevelOrder(30);
  tree.insertNodeLevelOrder(20.5);
  tree.insertNodeLevelOrder(10);
  tree.insertNodeLevelOrder(1);

  print("inorder iterative: ");
  tree.inorderIterative(tree.root);

  print("\npreorder iterative: ");
  tree.preorderIterative(tree.root);

  print("\npostorder iterative: ");
  tree.postorderIterative(tree.root);

  // print("Preorder traversal:");
  // tree.preorder(tree.root);

  // print("\nInorder traversal:");
  // tree.inorder(tree.root);

  // print("\nPostorder traversal:");
  // tree.postorder(tree.root);

  int n = 3;
  print("\nlevel order traversal of $n in binary tree is (recursion):");
  tree.printLevelOrder(tree.root,n);

  print("\nlevel order traversal of $n is binary tree is (non recursion) :");
  tree.printLevelOrderQueue(tree.root, n);

  print("\nHeight of tree is : ${tree.maxDepth(tree.root)}");
}