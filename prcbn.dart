import 'dart:collection';
import 'dart:io';

class Node<T> {
  T nodeValue;
  Node<T>? left, right;

  Node(this.nodeValue);
}

class BinaryTree<T> {
  Node<T>? root;

  BinaryTree() {
    root = null;
  }

  // Travesal Preorder
  void printPreOrder(Node<T>? node) {
    if (node != null) {
      stdout.write("${node.nodeValue} "); // N (node/root)
      printPreOrder(node.left); // L (left)
      printPreOrder(node.right); // R (right)
    }
  }

  void printPreOrderFromRoot() {
    printPreOrder(root);
  }

  void printInOrder(Node<T>? node) {
    if (node != null) {
      printInOrder(node.left); // L (left)
      stdout.write("${node.nodeValue} "); // N (node/root)
      printInOrder(node.right); // R (right)
    }
  }

  void printInOrderFromRoot() {
    printInOrder(root);
  }

  void printPostOrder(Node<T>? node) {
    if (node != null) {
      printPostOrder(node.left); // L (left)
      printPostOrder(node.right); // R (right)
      stdout.write("${node.nodeValue} "); // N (node/root)
    }
  }

  void printPostOrderFromRoot() {
    printPostOrder(root); // Memperbaiki pemanggilan fungsi yang salah
  }

  void insertData(T newValue) {
    Node<T> newNode = Node<T>(newValue);
    if (root == null) {
      root = newNode;
      return;
    } else {
      insertBasedOrderLevel(root!, newNode);
    }
  }

  bool insertBasedOrderLevel(Node<T> current, Node<T> newNode) {
    if (current.left == null) {
      current.left = newNode;
      return true;
    }
    if (current.right == null) {
      current.right = newNode;
      return true;
    }
    return insertBasedOrderLevel(current.left!, newNode) ||
        insertBasedOrderLevel(current.right!, newNode);
  }

  void InsertData(T newValue) {
    Node<T>? newNode = Node(newValue);
    if (root == null) {
      root = newNode;
      return;
    }

    Queue<Node<T>?> queue = Queue();
    queue.add(root);

    while (queue.isNotEmpty) {
      Node<T>? current = queue.removeFirst();

      if (current?.left == null) {
        current?.left = Node(newValue);
        return;
      } else {
        queue.add(current?.left);
      }

      if (current?.right == null) {
        current?.right = Node(newValue);
        return;
      } else {}
    }
  }

  void InOrderNonRekursif() {
    if (root == null) return;

    List<Node<T>> stack = [];
    Node<T>? curr = root;

    while (curr != null || stack.isNotEmpty) {
      while (curr != null) {
        stack.add(curr); // add sama dengan push di stack
        curr = curr.left;
      }
      // pop subtree sebelah kiri
      curr = stack.removeLast(); // sama dengan pop di stack
      stdout.write('${curr.nodeValue} '); // cetak di root
      curr = curr.right; //lakukan di subtree sebelah kanan
    }

    int maxDepth(Node? node) {
      if (node == null) {
        return 0;
      } else {
        int lDepth = maxDepth(node.left);
        int rDepth = maxDepth(node.right);
        return lDepth > rDepth ? lDepth + 1 : rDepth + 1;
      }
    }
  }
}
