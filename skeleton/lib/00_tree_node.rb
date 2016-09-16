class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []

  end

  def parent
    @parent

  end


  def children
    @children
  end


  def value
    @value
  end

  def add_child(child_node)
    if child_node != nil
      @children << child_node if !@children.include?(child_node)
      child_node.parent = self
    end
  end

  def remove_child(child)
    @children.delete(child) if child != nil
    child.parent = nil
  end


  def parent=(par)
    #@parent.remove_child(self) if !@parent.nil? && @parent != par
    @parent = par
    return nil if par == nil
    #@parent.add_child(self) if !@children.include?(self)
    @parent.children << self unless @parent.children.include?(self)
  end

end # exit PolyTreeNode class
