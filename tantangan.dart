import 'dart:io';
// import 'dart:collection';

class TreeNode<T> {
  T nodeValue;
  TreeNode<T>? left;
  TreeNode<T>? right;

  TreeNode(this.nodeValue)
      : left = null,
        right = null;
}

class BinaryTree<T> {
  TreeNode<T>? root;
  BinaryTree() : root = null;

  // traversal preorder (NLR)
  void preorder(TreeNode<T>? node) {
    if (node == null) return;
    stdout.write("${node.nodeValue} "); // N
    preorder(node.left); // L
    preorder(node.right); // R
  }

  void preorderIterative(TreeNode<T>? node) {
    if (node == null) return;
    List<TreeNode<T>?> stack = [];
    stack.add(node);
    while (stack.isNotEmpty) {
      TreeNode<T>? current = stack.removeLast();
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

  // traversal inorder (LNR)
  void inorder(TreeNode<T>? node) {
    if (node == null) return;
    inorder(node.left); // L
    stdout.write("${node.nodeValue} "); // N
    inorder(node.right); // R
  }

  void inorderIterative(TreeNode<T>? node) {
    if (node == null) return;
    List<TreeNode<T>?> stack = [];
    TreeNode<T>? current = node;

    while (current != null || stack.isNotEmpty) {
      while (current != null) {
        stack.add(current);
        current = current.left;
      }

      current = stack.removeLast();
      stdout.write("${current!.nodeValue} ");
      current = current!.right;
    }
    print("");
  }

  // traversal postorder (LRN)
  void postorder(TreeNode<T>? node) {
    if (node == null) return;
    postorder(node.left); // L
    postorder(node.right); // R
    stdout.write("${node.nodeValue} "); // N
  }

  void postorderIterative(TreeNode<T>? node) {
    if (node == null) return;
    List<TreeNode<T>?> stack1 = [];
    List<TreeNode<T>?> stack2 = [];
    stack1.add(node);
    while (stack1.isNotEmpty) {
      TreeNode<T>? current = stack1.removeLast();
      stack2.add(current);
      if (current!.left != null) {
        stack1.add(current!.left);
      }
      if (current!.right != null) {
        stack1.add(current!.right);
      }
    }
    while (stack2.isNotEmpty) {
      stdout.write("${stack2.removeLast()!.nodeValue} ");
    }
    print("");
  }

  // Mencetak Nilai pada Level tertentu berdasarkan Order Binary Tree
  void printLevelOrder(TreeNode<T>? node, int level) {
    if (node == null) return;
    if (level == 1) {
      stdout.write("${node.nodeValue} ");
    } else if (level > 1) {
      printLevelOrder(node.left, level - 1);
      printLevelOrder(node.right, level - 1);
    }
  }

  void printLevelOrderQueue(TreeNode<T>? node, int targetLevel) {
    if (node == null) return;

    List<TreeNode<T>?> queue = [];
    queue.add(node);
    int currentLevel = 1;

    while (queue.isNotEmpty && currentLevel <= targetLevel) {
      int levelSize = queue.length;

      for (int i = 0; i < levelSize; i++) {
        TreeNode<T>? current = queue.removeAt(0);

        if (currentLevel == targetLevel) {
          stdout.write("${current!.nodeValue} ");
        }

        if (current!.left != null) {
          queue.add(current.left);
        }
        if (current.right != null) {
          queue.add(current.right);
        }
      }

      if (currentLevel == targetLevel) {
        print("");
      }
      currentLevel++;
    }
  }

  // Menghitung Height of Tree dengan Rekursif
  int maxDepth(TreeNode<T>? node) {
    if (node == null) return 0;
    int leftDepth = maxDepth(node.left);
    int rightDepth = maxDepth(node.right);
    if (leftDepth > rightDepth) {
      return leftDepth + 1;
    } else {
      return rightDepth + 1;
    }
  }

  void insertNodeLevelOrder(T value) {
    if (root == null) {
      root = TreeNode(value);
      return;
    }

    List<TreeNode<T>?> queue = [];
    queue.add(root);

    while (queue.isNotEmpty) {
      TreeNode<T>? current = queue.removeAt(0);

      // Cek anak kiri
      if (current?.left == null) {
        current?.left = TreeNode(value);
        return;
      } else {
        queue.add(current?.left);
      }

      // Cek anak kanan
      if (current?.right == null) {
        current?.right = TreeNode(value);
        return;
      } else {
        queue.add(current?.right);
      }
    }
  }

  void insertNodeWithTarget(T value, T target) {
    if (root == null) {
      root = TreeNode(value);
      return;
    }

    List<TreeNode<T>?> queue = [];
    queue.add(root);

    while (queue.isNotEmpty) {
      TreeNode<T>? current = queue.removeAt(0);

      if (current?.nodeValue == target) {
        if (current?.left == null) {
          current?.left = TreeNode(value);
          return;
        } else if (current?.right == null) {
          current?.right = TreeNode(value);
          return;
        }
      }

      if (current?.left != null) {
        queue.add(current?.left);
      }
      if (current?.right != null) {
        queue.add(current?.right);
      }
    }

    insertNodeLevelOrder(value);
  }
}
