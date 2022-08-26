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
            nodes << node.value
            q << node.left if node.left
            q << node.right if node.right
        end

        nodes
    end

    def preorder(nodes=[], node=@root)
        return if node.nil?

        nodes << node.value
        preorder(nodes, node.left)
        preorder(nodes, node.right)

        nodes
    end

    def inorder(nodes=[], node=@root)
        return if node.nil?

        inorder(nodes, node.left)
        nodes << node.value
        inorder(nodes, node.right)

        nodes
    end

    def postorder(nodes=[], node=@root)
        return if node.nil?

        postorder(nodes, node.left)
        postorder(nodes, node.right)
        nodes << node.value
    end

    def insert(value)
    end

    def delete(value)
    end

    private

    def build_tree(array)
        return nil if array.empty?

        n = array.length

        parent = Node.new(array[n / 2], build_tree(array[0...n / 2]), build_tree(array[(n / 2) + 1..]))
    end
end

tree = Tree.new([3, 1, 2, 7, 5, 9])
p tree.inorder