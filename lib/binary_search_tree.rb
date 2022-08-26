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
        return @left.nil? && @right.nil?
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

    def preorder(nodes=[], node=@root, &block)
        return if node.nil?
        
        yield node if block_given?        
        nodes << node.value

        preorder(nodes, node.left, &block)
        preorder(nodes, node.right, &block)

        nodes
    end

    def inorder(nodes=[], node=@root, &block)
        return if node.nil?

        inorder(nodes, node.left, &block)

        yield node if block_given?   
        nodes << node.value

        inorder(nodes, node.right, &block)

        nodes
    end

    def postorder(nodes=[], node=@root, &block)
        return if node.nil?

        postorder(nodes, node.left, &block)
        postorder(nodes, node.right, &block)
        
        yield node if block_given?   
        nodes << node.value
    end

    def insert(value, node=@root)
        return Node.new(value) if node.nil?
        node.left = insert(value, node.left) if value < node.value
        node.right = insert(value, node.right) if value > node.value
        node == @root ? self : node
    end

    def delete(value, node=@root)
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

    private

    def build_tree(array)
        return nil if array.empty?

        n = array.length

        parent = Node.new(array[n / 2], build_tree(array[0...n / 2]), build_tree(array[(n / 2) + 1..]))
    end

    def smallest_node(node=@root)
        return node if node.leaf? || node.left.nil?
        
        smallest_node(node.left)
    end
end

tree = Tree.new([3, 1, 2, 7, 5, 9])
tree.insert(11)
p tree.inorder 
tree.delete(11)
p tree.inorder 