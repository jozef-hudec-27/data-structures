class Node
    attr_accessor :value, :next

    def initialize(value=nil, next=nil)
        @value = value
        @next = next
    end
end

class LinkedList
    def initialize
        @size = 0
        @head = nil
        @tail = nil
    end

    def append(value)
    end

    def prepend(value)
    end

    def at(index)
    end

    def pop(index)
    end

    def contains?(value)
    end

    def find(value)
    end

    def to_s(value)
    end

    def remove_at(index)
    end

    def insert_at(index)
    end
end