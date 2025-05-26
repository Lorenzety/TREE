import 'dart:io';

class Node<T>{
  T nodeValue;
  Node? left, right;

  Node(this.nodeValue);
}
  class BinaryTree {
    Node? root;

    BinaryTree(){
      root = null;
    }

    //Travesal Pre Order

    void PreOrder(Node? node) {
      if (node!= null) {
        stdout.write('${node.nodeValue}');
        PreOrder(node.left);
        PreOrder(node.right);
      }
    }

     void InOrder (Node) {
       if (Node != null) {
       InOrder(Node.left);
        stdout.write('${Node.nodeValue}');
        PreOrder(Node.right);
      } else {

     }
  }
  
    void PostOrder (Node? node) {
      if (node !=null) {
        stdout.write('${node.nodeValue} ');
        PostOrder(node.left);
        PostOrder(node.right);
      }
    }}