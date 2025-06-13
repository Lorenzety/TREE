class STNode<T> {
  T nodeValue;
  STNode<T>? left;
  STNode<T>? right;

  STNode(this.nodeValue);
}

class BinarySearchTree<T extends Comparable> {
  STNode<T>? root;

  STNode<T>? getRoot() => root;

  void add(T value) {
    root = _addRecursive(root, value);
  }

  STNode<T> _addRecursive(STNode<T>? node, T value) {
    if (node == null) return STNode<T>(value);
    if (value.compareTo(node.nodeValue) < 0) {
      node.left = _addRecursive(node.left, value);
    } else if (value.compareTo(node.nodeValue) > 0) {
      node.right = _addRecursive(node.right, value);
    }
    return node;
  }

  STNode<T> findNode(T item) {
    STNode<T>? t = root;
    while (t != null) {
      int cmp = item.compareTo(t.nodeValue);
      if (cmp == 0) return t;
      t = (cmp < 0) ? t.left : t.right;
    }
    throw Exception('Node not found');
  }

  void printNode(STNode<T>? node) {
    if (node != null) {
      printNode(node.left);
      print('${node.nodeValue}');
      printNode(node.right);
    }
  }

  void inorderIterative(STNode<T>? node) {
    final stack = <STNode<T>>[];
    STNode<T>? current = node;
    while (current != null || stack.isNotEmpty) {
      while (current != null) {
        stack.add(current);
        current = current.left;
      }
      current = stack.removeLast();
      print('${current.nodeValue}');
      current = current.right;
    }
  }

  void preorderIterative(STNode<T>? node) {
    if (node == null) return;
    final stack = <STNode<T>>[];
    stack.add(node);
    while (stack.isNotEmpty) {
      final current = stack.removeLast();
      print('${current.nodeValue}');
      if (current.right != null) stack.add(current.right!);
      if (current.left != null) stack.add(current.left!);
    }
  }

  void postorderIterative(STNode<T>? node) {
    if (node == null) return;
    final stack1 = <STNode<T>>[];
    final stack2 = <STNode<T>>[];

    stack1.add(node);
    while (stack1.isNotEmpty) {
      final current = stack1.removeLast();
      stack2.add(current);
      if (current.left != null) stack1.add(current.left!);
      if (current.right != null) stack1.add(current.right!);
    }

    while (stack2.isNotEmpty) {
      print('${stack2.removeLast().nodeValue}');
    }
  }

  void printTree([STNode<T>? node, String prefix = '', bool isTail = true]) {
    node ??= root;
    if (node == null) return;

    print(prefix + (isTail ? '╰─► ' : '├─► ') + '[ ${node.nodeValue} ]');

    final children = [node.right, node.left].whereType<STNode<T>>().toList();
    for (var i = 0; i < children.length; i++) {
      printTree(
        children[i],
        prefix + (isTail ? '    ' : '│   '),
        i == children.length - 1,
      );
    }
  }
}

void main() {
  BinarySearchTree<int> BSTree = BinarySearchTree<int>();

  BSTree.add(7);
  BSTree.add(4);
  BSTree.add(5);
  BSTree.add(9);
  BSTree.add(11);
  BSTree.add(12);

  print('\nVisualisasi Pohon BST:');
  BSTree.printTree();

  print('\nInorder traversal:');
  BSTree.inorderIterative(BSTree.getRoot());

  print('\nPreorder traversal:');
  BSTree.preorderIterative(BSTree.getRoot());

  print('\nPostorder traversal:');
  BSTree.postorderIterative(BSTree.getRoot());

  print('\nfindNode(9):');
  print(BSTree.findNode(9).nodeValue);
}
