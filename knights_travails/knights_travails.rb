require 'byebug'
require_relative 'poly_tree_node'

class KnightPathFinder

  def self.valid_moves(pos)
    possible_moves = []
    x, y = pos
    possible_moves << [x-2, y-1] if x > 1 && y > 0
    possible_moves << [x-2, y+1] if x > 1 && y < 7
    possible_moves << [x-1, y-2] if x > 0 && y > 1
    possible_moves << [x+1, y+2] if x < 7 && y < 6
    possible_moves << [x-1, y+2] if x > 0 && y < 6
    possible_moves << [x+2, y+1] if x < 6 && y < 7
    possible_moves << [x+2, y-1] if x < 6 && y > 0
    possible_moves << [x+1, y-2] if x < 7 && y > 1
    possible_moves
  end

  def initialize(start)
    @start = start
    @visited_positions = [start]
    @move_tree = build_move_tree

  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos) - @visited_positions
    @visited_positions += moves
    moves
  end

  def build_move_tree
    main_root = nil
    have_root = false
    queue = [PolyTreeNode.new(@visited_positions[0])]
    until queue.empty?
      root = queue.shift
      if have_root == false
        main_root = root
        have_root = true
      end
      moves = new_move_positions(root.value)
      moves.each do |move|
        child = PolyTreeNode.new(move)
        root.add_child(child)
      end
      queue += root.children
    end
    @start = main_root
  end

  def find_path(end_pos)
    end_node = @start.bfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(end_node)
    path = [end_node.value]
    parent = end_node.parent
    until parent.nil?
      path << parent.value
      parent = parent.parent
    end
    path.reverse
  end

end
