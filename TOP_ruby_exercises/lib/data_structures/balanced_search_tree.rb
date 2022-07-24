# frozen_string_literal: true 

module Comparable
  def compare(a, b)
    
  end
end

class Node  #:nodoc:
  attr_accessor :value, :right_node, :left_node

  def initialize(value = nil,  left_node = nil, right_node = nil)
    @value = value
    @left_node = left_node
    @right_node = right_node
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(arr)  # refactor to reduce complexity/redundnancy
    sorted = arr.sort.uniq
    min = 0.0
    max = sorted.length-1.to_f
    mid = ((min + max)/2).ceil()
    val = sorted[mid]
    if sorted.length > 2
      lower_vals_arr = sorted[0, mid]  
      higher_vals_arr = sorted[mid + 1, (sorted.length - 1) - mid]  # better way to make this sub array
    
      tree = Node.new(val, build_tree(lower_vals_arr), build_tree(higher_vals_arr))
    end
    if arr.length == 2
      lower_vals_arr = sorted[0, mid]
      tree = Node.new(val, build_tree(lower_vals_arr))
    end
    if arr.length == 1
      tree = Node.new(val)
    end
    tree
  end

  def insert(value)  # refactor to reduce complexity/redundnancy
    tmp = root
    until tmp.nil?
      if value > tmp.value
        if  tmp.right_node.nil?
          tmp.right_node = Node.new(value) 
          return self
        else
          tmp = tmp.right_node
          next
        end
      elsif value < tmp.value
        if  tmp.left_node.nil?
          tmp.left_node = Node.new(value) 
          return self
        else
          tmp = tmp.left_node
          next
        end
      else
        puts 'Value already exists in tree'
        return self
      end
    end
  end

  def farthest_left_value(node)
    tmp = node
    until tmp.left_node.nil?
      tmp = tmp.left_node
    end
    tmp.value
  end

  def delete(value, node = self.root) # refactor to reduce complexity/redundnancy
    return node if node.nil?

    if node.value > value
      node.left_node = delete(value, node.left_node)
    elsif node.value < value
      node.right_node = delete(value, node.right_node)
    else
      return nil if node.right_node.nil? && node.left_node.nil?

      return node.left_node if node.right_node.nil? && !node.left_node.nil?

      return node.right_node if !node.right_node.nil? && node.left_node.nil?

      value = farthest_left_value(node.right_node)
      node.right_node = delete(value, node.right_node)
      node.value = value
    end
    node
  end

  def find(value)
    tmp = root
    until tmp.nil?
      return tmp if tmp.value == value

      tmp = tmp.value > value ? tmp.left_node : tmp.right_node
    end
  end

  # # breadth first traversal (iteration)
  # def level_order
  #   node = self.root
  #   queue = []
  #   array = []
  #   queue << node
  #   until queue.empty?
  #     queue << node.left_node unless node.left_node.nil?
  #     queue << node.right_node unless node.right_node.nil?
  #     array << queue[0].value
  #     queue.shift
  #     node = queue[0]
  #   end
  #   array
  # end

  # breadth first traversal (recursion)

  def level_order(node = root, queue = [root], array = [])
    return array if queue.empty?

    queue << node.left_node unless node.left_node.nil?
    queue << node.right_node unless node.right_node.nil?
    array << queue[0].value
    queue.shift
    level_order(queue[0], queue, array)
  end

  def inorder(node = root, array = [])
    return array if node.nil?

    inorder(node.left_node, array)
    array << node.value
    inorder(node.right_node, array)
  end

  def preorder(node = root, array = [])
    return array if node.nil?

    array << node.value
    preorder(node.left_node, array)
    preorder(node.right_node, array)
  end

  def postorder(node = root, array = [])
    return array if node.nil?

    postorder(node.left_node, array)
    postorder(node.right_node, array)
    array << node.value
  end

  def depth(node, tmp = root, counter = 0)
    if tmp.value < node.value
      counter += 1
      depth(node, tmp.right_node, counter)
    elsif tmp.value > node.value
      counter += 1
      depth(node, tmp.left_node, counter)
    else
      counter
    end
  end

  def height(node, count = 0, arr = [])
    return count if node.right_node.nil? && node.left_node.nil?

    unless node.right_node.nil?
      count += 1
      height(node.right_node, count, arr)
      arr << count
    end
    unless node.left_node.nil?
      count += 1
      height(node.left_node, count, arr)
      arr << count
    end
    arr.max
  end

  def balanced?(node = self.root, result = true) # refactor to reduce complexity/redundnancy

    r = node.right_node.nil? ? 0 : height(node.right_node)
    l = node.left_node.nil? ? 0 : height(node.left_node)
    result = false if [l, r].max - [l, r].min > 1
    return result if result ==false

    result = balanced?(node.left_node) unless node.left_node.nil?
    result = balanced?(node.right_node, result) unless node.right_node.nil?
    result
  end

  def rebalance
    array = level_order
    Tree.new(array)
  end
end

array = Array.new(15) {rand(1..1000)}
tree = Tree.new(array)
p tree.balanced?
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder
200.times { tree.insert(rand(1-5000))}
p tree.balanced?
tree = tree.rebalance
p tree.balanced?
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder
