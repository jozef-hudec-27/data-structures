class Node
  attr_accessor :value, :nxt

  def initialize(value = nil, nxt = nil)
    @value = value
    @nxt = nxt
  end

  def to_s
    @value.nil? ? 'nil' : @value
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

    self
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    @head = new_node
    @tail = new_node if @tail.nil?
    @size += 1

    self
  end

  def at(index)
    raise 'Index cannot be negative' if index.negative?

    raise 'Index too high' if index >= @size

    node = @head

    index.times { node = node.nxt }

    node
  end

  def pop
    raise 'Cannot pop from empty linked list' if @head.nil?

    removed_node = @tail

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
    removed_node
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
      nodes.push(node.to_s)
      node = node.nxt
    end

    nodes.join(' -> ')
  end

  def remove_at(index)
    raise 'Index too low' if index < -@size

    raise 'Index too high' if index >= @size

    index = @size + index if index.negative?

    if index.zero?
      removed_node = @head
      @head = @head&.nxt
    elsif index == @size - 1
      removed_node = pop
    else
      node_before = @head

      (index - 1).times { node_before = node_before.nxt }

      removed_node = node_before.nxt
      node_before.nxt = node_before.nxt.nxt
    end

    @size -= 1

    removed_node
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
          @head = Node.new
          @tail = @head
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

    self
  end
end

linked_list = LinkedList.new
linked_list.append('b')
linked_list.append('c')
linked_list.prepend('a')
puts linked_list
