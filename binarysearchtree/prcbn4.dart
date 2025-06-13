class STNode<T> {
  T nodeValue;
  STNode<T>? left, right, parent;

  STNode(this.nodeValue);
}

class BinarySearchTree<T extends Comparable> {
  STNode<T>? root;
  int treeSize = 0;

  STNode<T>? getRoot() => root;

  void add(T value) {
    root = _addRecursive(root, value, null);
  }

  STNode<T> _addRecursive(STNode<T>? node, T value, STNode<T>? parent) {
    if (node == null) {
      treeSize++;
      final newNode = STNode(value);
      newNode.parent = parent;
      return newNode;
    }

    if (value.compareTo(node.nodeValue) < 0) {
      node.left = _addRecursive(node.left, value, node);
    } else {
      node.right = _addRecursive(node.right, value, node);
    }
    return node;
  }

  STNode<T> findNode(T value) {
    STNode<T>? current = root;
    while (current != null) {
      if (value == current.nodeValue) return current;
      current = value.compareTo(current.nodeValue) < 0
          ? current.left
          : current.right;
    }
    throw Exception('Node not found');
  }

  bool find(T item) {
    try {
      findNode(item);
      return true;
    } catch (_) {
      return false;
    }
  }

  void removeNode(STNode<T>? dNode) {
    if (dNode == null) return;

    STNode<T>? pNode = dNode.parent;
    STNode<T>? rNode;

    // Kasus: node dengan 0 atau 1 anak
    if (dNode.left == null || dNode.right == null) {
      rNode = dNode.left ?? dNode.right;

      if (rNode != null) {
        rNode.parent = pNode;
      }

      if (pNode == null) {
        root = rNode;
      } else if (dNode == pNode.left) {
        pNode.left = rNode;
      } else {
        pNode.right = rNode;
      }
    }
    // Kasus: node dengan 2 anak
    else {
      STNode<T>? successor = dNode.right;
      while (successor!.left != null) {
        successor = successor.left;
      }

      dNode.nodeValue = successor.nodeValue;
      removeNode(successor); // rekursif: sekarang pasti kasus 0/1 anak
      return;
    }

    treeSize--;
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
    while (stack.isNotEmpty || current != null) {
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
    final stack1 = <STNode<T>>[], stack2 = <STNode<T>>[];
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

  [7, 4, 5, 9, 11, 12].forEach(BSTree.add);

  print('=== Pohon Sebelum Penghapusan ===');
  BSTree.printNode(BSTree.getRoot());

  print('\nInorder:');
  BSTree.inorderIterative(BSTree.getRoot());

  print('\nPreorder:');
  BSTree.preorderIterative(BSTree.getRoot());

  print('\nPostorder:');
  BSTree.postorderIterative(BSTree.getRoot());

  print('\nFind node 9:');
  try {
    var node = BSTree.findNode(9);
    print('Ditemukan: ${node.nodeValue}');
  } catch (e) {
    print('Node tidak ditemukan.');
  }

  print('\nTree Size: ${BSTree.treeSize}');

  try {
    var node = BSTree.findNode(5);
    print('Node found with value: ${node.nodeValue}');
  } catch (e) {
    print('Node not found.');
  }

  bool nodeFind = BSTree.find(5);
  print(nodeFind ? 'Node found' : 'Node not found');

  // Penghapusan node
  try {
    STNode<int>? nodeToRemove = BSTree.findNode(5);
    print('\nMenghapus node dengan nilai: ${nodeToRemove.nodeValue}');
    BSTree.removeNode(nodeToRemove);
  } catch (e) {
    print('Node tidak dapat dihapus karena tidak ditemukan.');
  }

  print('\n=== Pohon Setelah Penghapusan ===');
  BSTree.printNode(BSTree.getRoot());

  print('\nTree Size setelah penghapusan: ${BSTree.treeSize}');
}

