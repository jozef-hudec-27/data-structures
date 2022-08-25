class Node
  attr_accessor :value, :nxt

  def initialize(value = nil, nxt = nil)
    @value = value
    @nxt = nxt
  end
end

class LinkedList
  def initialize
    @size = 0
    @head = nil
    @tail = nil
  end

  def append(value)
    new_node = Node.new(value)
    @tail&.nxt = new_node
    @tail = new_node
    @head = new_node if @head.nil?
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    @head = new_node
    @tail = new_node if @tail.nil?
  end

  def at(index)
  end

  def pop(index)
  end

  def contains?(value)
  end

  def find(value)
  end

  def to_s
    nodes = []
    node = @head

    while node
      nodes << node.value
      node = node.nxt
    end

    nodes.join(' -> ')
  end

  def remove_at(index)
  end

  def insert_at(index)
  end
end

my_linked_list = LinkedList.new
my_linked_list.append(1)
my_linked_list.append(2)
puts my_linked_list.to_s
