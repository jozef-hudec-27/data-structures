class Node
  attr_accessor :value, :nxt

  def initialize(value = nil, nxt = nil)
    @value = value
    @nxt = nxt
  end
end

class LinkedList
  attr_reader :head, :tail

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
    node = @head

    index.times do
      raise 'Index too high' if node.nil?

      node = node.nxt
    end

    node
  end

  def pop
    raise 'Cannot pop from empty linked list' if @head.nil?

    if @head == @tail
      @head, @tail = nil, nil
    else
      node = @head

      while node
        if node.nxt == @tail
          node.nxt = nil
          @tail = node
        end

        node = node.nxt
      end
    end
  end

  def contains?(value)
    node = @head

    while node
      return true if node.value == value
    end

    false
  end

  def find(value)
    idx = 0
    node = @head

    while node
      return idx if node.value == value

      node = node.nxt
      idx += 1
    end

    -1
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
puts my_linked_list.at(47).value
