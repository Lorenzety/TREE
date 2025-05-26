import 'prcbn.dart';

void main() {

    BinaryTree btree = BinaryTree();
    //btree.root = Node(1);
    //btree.root!.left = Node(2);
    //btree.root!.right = Node(3);
    //btree.root!.left!.left = Node("a");

    btree.insertData(1);
    btree.insertData(2);
    btree.insertData(3);
    btree.insertData(4);
    btree.insertData(5);
    btree.insertData(6);

    print("pre order Travesal Binary Tree: ");
    btree.printPreOrder(btree.root);

    print(" ");
    print("In Order Travesal Binary Tree: ");
    btree.printInOrder(btree.root);

    print(" ");
    print("Post Order Travesal Binary Tree: ");
    btree.printPostOrder(btree.root);
    
}