class Node
  attr_accessor :value, :left, :right

  def initialize(value = nil, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def to_s
    @value.nil? ? 'nil' : value.to_s
  end

  def leaf?
    @left.nil? && @right.nil?
  end
end

class Tree
  attr_reader :root

  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def level_order
    q = [@root]
    nodes = []

    until q.empty?
      node = q.shift
      yield node if block_given?
      nodes << node.value
      q << node.left if node.left
      q << node.right if node.right
    end

    nodes
  end

  def preorder(nodes = [], node = @root, &block)
    return if node.nil?

    yield node if block_given?
    nodes << node.value

    preorder(nodes, node.left, &block)
    preorder(nodes, node.right, &block)

    nodes
  end

  def inorder(nodes = [], node = @root, &block)
    return if node.nil?

    inorder(nodes, node.left, &block)

    yield node if block_given?
    nodes << node.value

    inorder(nodes, node.right, &block)

    nodes
  end

  def postorder(nodes = [], node = @root, &block)
    return if node.nil?

    postorder(nodes, node.left, &block)
    postorder(nodes, node.right, &block)

    yield node if block_given?
    nodes << node.value
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    node.left = insert(value, node.left) if value < node.value
    node.right = insert(value, node.right) if value > node.value
    node == @root ? self : node
  end

  def delete(value, node = @root)
    return if node.nil?

    if value < node.value
      node.left = delete(value, node.left)
    elsif value > node.value
      node.right = delete(value, node.right)
    else
      if node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      end

      temp = smallest_node(node.right)
      node.value = temp.value
      node.right = delete(temp.value, node.right)
    end

    node
  end

  def find(value, node = @root)
    return node if node.nil? || node.value == value

    find(value, node.left) || find(value, node.right)
  end

  def height(node = @root)
    return 0 if node.nil? || node.leaf?

    1 + [height(node.left), height(node.right)].max
  end

  def depth(node, root = @root)
    return -1 if root.nil?
    return 0 if root == node

    1 + depth(node, root.left) || depth(node, root.right)
  end

  def balanced?(node = @root)
    return true if node.leaf?

    if node.left.nil?
      return node.right.leaf?
    elsif node.right.nil?
      return node.left.leaf?
    end

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    @root = build_tree(level_order)
  end

  def invert(node = @root)
    return node if node.nil? || node.leaf?

    invert(node.left)
    invert(node.right)
    node.left, node.right = node.right, node.left
  end

  private

  def build_tree(array)
    return nil if array.empty?

    n = array.length

    Node.new(array[n / 2], build_tree(array[0...n / 2]), build_tree(array[(n / 2) + 1..]))
  end

  def smallest_node(node = @root)
    return node if node.leaf? || node.left.nil?

    smallest_node(node.left)
  end
end

tree = Tree.new((Array.new(15) { rand(1..100) }))
puts "Balanced: #{tree.balanced?}"
puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
puts "Inorder: #{tree.inorder}"
tree.insert(110)
tree.insert(120)
tree.insert(300)
puts "Balanced: #{tree.balanced?}"
tree.rebalance
puts "Balanced: #{tree.balanced?}"
puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
puts "Inorder: #{tree.inorder}"
