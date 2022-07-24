require 'pry'
require 'pry-byebug'

class Node #:nodocs:
  attr_accessor :value, :visited, :moves

  @@nodes = []

  def initialize(value)
    @value = value
    @visited = false
    @@nodes << self if @@nodes.find{ |n| n.value == self.value } == nil
    @moves = build_moves(value)
  end

  def build_moves(pos)
    moves = moves_arr(pos)
    moves.reject! { |arr| !(0..7).include?(arr[0]) || !(0..7).include?(arr[1])}
    moves.map { |v| make_nodes(v) }
  end

  def make_nodes(val)
    result = @@nodes.find{ |n| n.value == val }
    !result.nil? ? result : Node.new(val)
  end

  def moves_arr(pos)
    arr = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
    a = pos[0]
    b = pos[1]
    arr.map{ |array| [(array[0] + a), (array[1] + b)] }
  end

  class << self
    def nodes_count
      @@nodes.each { |node| p node.value}
      @@nodes.count
    end
  end
  
end

class Graph
  attr_accessor :root

  def initialize(value)
    @root = Node.new(value)
  end

  def mark_unvsitied(queue = [self.root], switched = [self.root])
    until queue.empty?
      current_node = queue.shift
      current_node.visited = false
      current_node.moves.each do |node|
        next if switched.include?(node)

        node.visited = false
        switched << node
        queue << node
      end
    end
  end

  def level_order(queue = [self.root], order = [] )
    mark_unvsitied
    queue[0].visited = true
    until queue.empty?
      current_node = queue.shift
      order << current_node.value
      current_node.moves.each do |node|
        if node.visited == false
          node.visited = true
          queue << node
        end
      end
    end
    mark_unvsitied
    order
  end

end

def path_array(dest, pred, master)
  path = []
  path << dest
  dest_idx = master.index(dest)
  until pred[dest_idx].nil?
    path << pred[dest_idx]
    parent = pred[dest_idx]
    dest_idx = master.index(parent)
  end
  path.reverse
end

def create_default_array(num, sym)
  arr = []
  num.times { arr << sym }
  arr
end

def output_moves(dest, dist, pred, master)
  dest_idx = master.index(dest)
  array = path_array(dest, pred, master)
  p "You made it in #{dist[dest_idx]} moves.  Here's your path:"
  array.each { |a| p a}
  # add return value for knight_moves here.
end

def knight_moves(start, dest, queue = [])
  graph = Graph.new(start)
  master = graph.level_order
  dist = create_default_array(master.length, -1)
  pred = create_default_array(master.length, nil)
  queue << graph.root
  until queue.empty?
    current = queue.shift
    parent_idx = master.index(current.value)
    if parent_idx.zero?
      dist[parent_idx] = 0 
      pred[parent_idx] = nil
    end
    current.moves.each do |node|
      next if node.visited == true

      child_idx = master.index(node.value)
      dist[child_idx] = dist[parent_idx] + 1 if dist[child_idx] == -1
      pred[child_idx] = current.value if pred[child_idx].nil?
      node.visited = true
      queue << node
    end
  end
  output_moves(dest, dist, pred, master)
end

knight_moves([4, 4], [6, 6])
knight_moves([4, 1], [6, 6])
knight_moves([0, 1], [6, 6])
knight_moves([3, 3], [6, 6])
