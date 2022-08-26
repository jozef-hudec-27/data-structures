class Node
  attr_accessor :value, :nxt

  def initialize(value = nil, nxt = nil)
    @value = value
    @nxt = nxt
  end
end

class LinkedList
  attr_reader :head, :tail, :size

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
    @size += 1
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    @head = new_node
    @tail = new_node if @tail.nil?
    @size += 1
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

    @size -= 1
  end

  def contains?(value)
    node = @head

    while node
      return true if node.value == value

      node = node.nxt
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
      nodes.push(node.value || 'nil')
      node = node.nxt
    end

    nodes.join(' -> ')
  end

  def remove_at(index)
    raise 'Invalid index' if index < -@size || index >= @size

    index = @size + index if index.negative?

    if index.zero?
      @head = @head&.nxt
    elsif index == @size - 1
      pop
    else
      node_before = @head

      (index - 1).times { node_before = node_before&.nxt }

      node_before.nxt = node_before.nxt.nxt
    end

    @size -= 1
  end

  def insert_at(index, value)
    raise 'Invalid index' if index.negative?

    new_node = Node.new(value)

    if index.zero?
      prepend(value)
    elsif index == @size
      append(value)
    else
      node_before = index - 1 < @size ? at(index - 1) : nil 
      unless node_before
        if @head.nil?
          @head = Node.new(nil, Node.new)
          @tail = @head.nxt
          @size = 1
        end

        node_before = @tail

        (index - @size).times do
          if node_before.nxt.nil?
            node_before.nxt = Node.new
            @size += 1
          end

          node_before = node_before.nxt
        end

      end

      node_before.nxt, new_node.nxt = new_node, node_before.nxt        
      @size += 1
    end
  end

end

my_linked_list = LinkedList.new
my_linked_list.append(1)
my_linked_list.append(2)
my_linked_list.append(3)
my_linked_list.append(4)
my_linked_list.append(5)
my_linked_list.prepend(-1)
my_linked_list.insert_at(10, 1488)
p [my_linked_list.to_s, my_linked_list.size]
