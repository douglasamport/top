# frozen_string_literal: true 

require 'pry'
require 'pry-byebug'

class LinkedList #:nodoc:
  attr_accessor :head

  def initialize
    @head = nil
    
  end
  
  def prepend(value)
    if self.head == nil
      self.head = Node.new(value)
    else
      tmp = self.head
      self.head = Node.new(value, tmp)
    end
  end

  def traverse
    tmp = self.head
    while !tmp.nil?
      p tmp.value
      
      tmp = tmp.next_node
    end
  end

  def append(value)
    if self.head == nil
      self.head = Node.new(value)
    else
      tmp = self.head
      while !tmp.next_node.nil?
        tmp = tmp.next_node
      end
      tmp.next_node = Node.new(value)
    end
  end

  def size
    tmp = self.head
    counter = 0
    while !tmp.nil?
      counter += 1
      tmp = tmp.next_node
    end
    puts counter
    counter
  end

  def tail
    tmp = self.head
    if tmp.nil?
      tmp
    else
      while !tmp.next_node.nil?
        tmp = tmp.next_node
      end
      tmp
    end
  end

  def at(index)
    count = 0
    tmp = self.head
    while count != index  
      return "index not found" if tmp.nil?
      
      tmp = tmp.next_node
      count += 1
    end
    tmp.value
  end

  def pop
    tmp = self.head
    while !tmp.nil?
      if tmp.next_node.next_node == nil
        node = tmp.next_node
        tmp.next_node = nil
        return node
      else
        tmp = tmp.next_node
      end
    end
  end

  def contains?(data)
    tmp = self.head
    while !tmp.nil?
      return true if tmp.value == data

      tmp = tmp.next_node
    end
    false
  end

  def find(data)
    count = 0
    tmp = self.head
    while !tmp.nil? 
      if tmp.value == data
        return count 
      end
      tmp = tmp.next_node
      count += 1
    end
    nil
  end

  def to_s
    tmp = self.head
    while !tmp.nil?
      puts tmp.value
      tmp = tmp.next_node
    end
    nil
  end

  def insert_at(data, index)
    count = 0
    tmp = self.head
    while !tmp.nil? 
      # find index before insertion point
      if count == index-1
        # add new node with pointer to current node at insertion point
        new_node = Node.new(data, tmp.next_node)
        # update Previous node to point to new node
        tmp.next_node = new_node
        return
      end
      tmp = tmp.next_node
      count += 1
    end
    nil
  end

  def remove_at(index)
    count = 0
    tmp = self.head
    while !tmp.nil? 
      # advance to node before removal point (tmp)
      if count == index-1
        # collect node to be removed (rem_node) just in case we want it
        rem_node = tmp.next_node
        # change pointer of pre_node to point to post_node effectivly skipping over node
        prev_node = tmp.next_node.next_node
        tmp.next_node = prev_node
        return rem_node
      elsif count > index
        return nil
      end
      tmp = tmp.next_node
      count += 1
    end
    
  end
  

end



class Node  #:nodoc:
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end


list = LinkedList.new

list.prepend(6)

list.prepend(5)

list.prepend(4)
list.prepend(3)
list.prepend(2)
list.prepend(1)
list.append(8)
list.append(9)

list.traverse
list.insert_at(7, 6)
list.traverse
list.remove_at(3)
list.traverse


#p list