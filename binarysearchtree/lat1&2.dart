import 'dart:io';

class STNode<T> {
  T value;
  STNode<T>? left, right, parent;
  STNode(this.value, [this.parent]);
}

class BinarySearchTree<T extends Comparable> {
  STNode<T>? root;
  int size = 0;

  bool add(T value) {
    STNode<T>? current = root, parent;
    while (current != null) {
      parent = current;
      int cmp = value.compareTo(current.value);
      if (cmp == 0) return false;
      current = cmp < 0 ? current.left : current.right;
    }

    var newNode = STNode(value, parent);
    if (parent == null)
      root = newNode;
    else if (value.compareTo(parent.value) < 0)
      parent.left = newNode;
    else
      parent.right = newNode;

    size++;
    return true;
  }

  T first() {
    if (root == null) throw Exception("Tree is empty");
    var current = root!;
    while (current.left != null) current = current.left!;
    return current.value;
  }

  T last() {
    if (root == null) throw Exception("Tree is empty");
    var current = root!;
    while (current.right != null) current = current.right!;
    return current.value;
  }

  void inorder() {
    var stack = <STNode<T>>[];
    var current = root;
    while (current != null || stack.isNotEmpty) {
      while (current != null) {
        stack.add(current);
        current = current.left;
      }
      current = stack.removeLast();
      stdout.write("${current.value} ");
      current = current.right;
    }
    print("");
  }

  STNode<T> _findNode(T value) {
    var current = root;
    while (current != null) {
      int cmp = value.compareTo(current.value);
      if (cmp == 0) return current;
      current = cmp < 0 ? current.left : current.right;
    }
    throw Exception("Node not found");
  }

  bool find(T value) {
    try {
      _findNode(value);
      return true;
    } catch (_) {
      return false;
    }
  }

  void remove(T value) {
    var node = _findNode(value);
    _removeNode(node);
  }

  void _removeNode(STNode<T> node) {
    STNode<T>? parent = node.parent;
    STNode<T>? child;

    if (node.left == null || node.right == null) {
      child = node.left ?? node.right;
      if (child != null) child.parent = parent;

      if (parent == null)
        root = child;
      else if (node.value.compareTo(parent.value) < 0)
        parent.left = child;
      else
        parent.right = child;
    } else {
      var successor = node.right!;
      while (successor.left != null) successor = successor.left!;
      node.value = successor.value;
      _removeNode(successor);
      return;
    }
    size--;
  }

  void printTree([STNode<T>? node, String prefix = '', bool isTail = true]) {
    node ??= root;
    if (node == null) return;

    stdout.write(prefix + (isTail ? "╰─► " : "├─► "));
    print("[ ${node.value} ]");

    final children = [node.right, node.left].whereType<STNode<T>>().toList();
    for (var i = 0; i < children.length; i++) {
      printTree(children[i], prefix + (isTail ? "    " : "│   "), i == children.length - 1);
    }
  }
}

void main() {
  var bst = BinarySearchTree<int>();
  for (var n in [35, 18, 25, 48, 20]) {
    bst.add(n);
  }

  print("Nilai terkecil: ${bst.first()}");
  print("Nilai terbesar: ${bst.last()}");

  print("\nIn-order traversal:");
  bst.inorder();

  print("\nVisualisasi Tree:");
  bst.printTree();
}
