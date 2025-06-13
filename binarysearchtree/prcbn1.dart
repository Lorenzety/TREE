import 'dart:io';


class STNode<T> {
  T nodeValue;
  STNode<T>? left, right, parent;


  // Konstruktor untuk simpul tanpa anak
  STNode(this.nodeValue, [this.parent]) {
    left = null;
    right = null;
  }


  // Konstruktor untuk simpul dengan anak
  STNode.withChildren(this.nodeValue, this.left, this.right) {
    parent = null;
  }
}


class BinarySearchTree<T> {
  STNode<T>? root;
  int treeSize = 0;


  // Konstruktor BST kosong
  BinarySearchTree() {
    root = null;
  }


  // Method untuk mendapatkan referensi root
  STNode<T>? getRoot() {
    return root;
  }


  void preorderIterative(STNode<T>? node) {
    if (node == null) return;
    List<STNode<T>?> stack = [];
    stack.add(node);
    while (stack.isNotEmpty) {
      STNode<T>? current = stack.removeLast();
      stdout.write("${current!.nodeValue} ");
      if (current.right != null) {
        stack.add(current.right);
      }
      if (current.left != null) {
        stack.add(current.left);
      }
    }
    print("");
  }


  void postorderIterative(STNode<T>? node) {
    if (node == null) return;
    List<STNode<T>?> stack1 = [];
    List<STNode<T>?> stack2 = [];
    stack1.add(node);
    while (stack1.isNotEmpty) {
      STNode<T>? current = stack1.removeLast();
      stack2.add(current);
      if (current!.left != null) {
        stack1.add(current.left);
      }
      if (current.right != null) {
        stack1.add(current.right);
      }
    }
    while (stack2.isNotEmpty) {
      stdout.write("${stack2.removeLast()!.nodeValue} ");
    }
  }


  void inorderIterative(STNode<T>? node) {
    if (node == null) return;
    List<STNode<T>?> stack = [];
    STNode<T>? current = node;


    while (current != null || stack.isNotEmpty) {
      while (current != null) {
        stack.add(current);
        current = current.left;
      }


      current = stack.removeLast();
      stdout.write("${current!.nodeValue} ");
      current = current.right;
    }
    print("");
  }


  bool add(T item) {
    STNode<T>? t = root, parent;
    int orderValue = 0;
    while (t != null) {
      parent = t;
      orderValue = (item as Comparable).compareTo(t.nodeValue);
      if (orderValue == 0) {
        return false;
      } else if (orderValue < 0) {
        t = t.left;
      } else {
        t = t.right;
      }
    }
    STNode<T> newNode = STNode(item, parent);
    if (parent == null) {
      root = newNode;
    } else if (orderValue < 0) {
      parent.left = newNode;
    } else {
      parent.right = newNode;
    }
    treeSize++;
    return true;
  }


  printNode<T>(STNode<T>? node, [String prefix = '', bool isTail = true]) {
    if (node != null) {
      // Print current node with decorative elements
      stdout.write(prefix);
      stdout.write(isTail ? '╰─► ' : '├─► ');


      // Add some visual styling to the node value
      stdout.write('[ ');
      stdout.writeln('${node.nodeValue} ]');


      // Collect child nodes
      final List<STNode<T>?> children = [];
      if (node.right != null) children.add(node.right);
      if (node.left != null) children.add(node.left);


      // Print child nodes recursively
      for (int i = 0; i < children.length; i++) {
        final child = children[i];
        final isLast = i == children.length - 1;


        // Use different connecting lines for better visual hierarchy
        printNode(
          child,
          prefix + (isTail ? '    ' : '│   '),
          isLast,
        );
      }
    }
  }
}


void main() {
  BinarySearchTree<int> BSTree = BinarySearchTree();


  BSTree.add(7);
  BSTree.add(4);
  BSTree.add(5);
  BSTree.add(9);
  BSTree.add(11);
  BSTree.add(12);


  BSTree.printNode(BSTree.getRoot());
  print('\ninorder :');
  BSTree.inorderIterative(BSTree.getRoot());
  print('\npreorder :');
  BSTree.preorderIterative(BSTree.getRoot());
  print('\npostorder :');
  BSTree.postorderIterative(BSTree.getRoot());
}
