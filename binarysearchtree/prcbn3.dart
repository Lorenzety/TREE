class STNode<T> {
  T nodeValue;
  STNode<T>? left;
  STNode<T>? right;

  STNode(this.nodeValue);
}

class BinarySearchTree<T extends Comparable> {
  STNode<T>? _root;
  int treeSize = 0;

  STNode<T>? getRoot() => _root;

  void add(T value) {
    _root = _addRecursive(_root, value);
  }

  STNode<T> _addRecursive(STNode<T>? node, T value) {
    if (node == null) {
      treeSize++;
      return STNode(value);
    }
    if (value.compareTo(node.nodeValue) < 0) {
      node.left = _addRecursive(node.left, value);
    } else {
      node.right = _addRecursive(node.right, value);
    }
    return node;
  }

  STNode<T> findNode(T value) {
    var current = _root;
    while (current != null) {
      if (value == current.nodeValue) {
        return current;
      } else if (value.compareTo(current.nodeValue) < 0) {
        current = current.left;
      } else {
        current = current.right;
      }
    }
    throw Exception('Node not found');
  }

  bool find(T value) {
    try {
      findNode(value);
      return true;
    } catch (_) {
      return false;
    }
  }

  void printNode(STNode<T>? node, [String prefix = "", bool isLeft = true]) {
    if (node == null) return;
    if (node.right != null) {
      printNode(node.right, prefix + (isLeft ? "│   " : "    "), false);
    }

    print(prefix + (isLeft ? "└── " : "┌── ") + "${node.nodeValue}");

    if (node.left != null) {
      printNode(node.left, prefix + (isLeft ? "    " : "│   "), true);
    }
  }

  void inorderIterative(STNode<T>? root) {
    final stack = <STNode<T>>[];
    var current = root;

    while (current != null || stack.isNotEmpty) {
      while (current != null) {
        stack.add(current);
        current = current.left;
      }
      current = stack.removeLast();
      print(current.nodeValue);
      current = current.right;
    }
  }

  void preorderIterative(STNode<T>? root) {
    if (root == null) return;
    final stack = [root];

    while (stack.isNotEmpty) {
      final node = stack.removeLast();
      print(node.nodeValue);

      if (node.right != null) stack.add(node.right!);
      if (node.left != null) stack.add(node.left!);
    }
  }

  void postorderIterative(STNode<T>? root) {
    if (root == null) return;

    final stack1 = <STNode<T>>[];
    final stack2 = <STNode<T>>[];

    stack1.add(root);

    while (stack1.isNotEmpty) {
      final node = stack1.removeLast();
      stack2.add(node);

      if (node.left != null) stack1.add(node.left!);
      if (node.right != null) stack1.add(node.right!);
    }

    while (stack2.isNotEmpty) {
      print(stack2.removeLast().nodeValue);
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

  print('Visual Tree (Phon Tree):');
  BSTree.printNode(BSTree.getRoot());

  print('\nInorder:');
  BSTree.inorderIterative(BSTree.getRoot());

  print('\nPreorder:');
  BSTree.preorderIterative(BSTree.getRoot());

  print('\nPostorder:');
  BSTree.postorderIterative(BSTree.getRoot());

  print('\nFind node:');
  try {
    var foundNode = BSTree.findNode(9);
    print('Ditemukan: ${foundNode.nodeValue}');
  } catch (e) {
    print('Node tidak ditemukan.');
  }

  print('Tree Size: ${BSTree.treeSize}');

  try {
    var node = BSTree.findNode(5);
    print('Node found with value: ${node.nodeValue}');
  } catch (e) {
    print('Node not found.');
  }

  bool nodeFind = BSTree.find(5);
  print(nodeFind ? 'Node found' : 'Node not found.');
}
