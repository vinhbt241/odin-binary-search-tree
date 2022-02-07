class Node
  attr_accessor :data, :left_node, :right_node

  def initialize(data = nil, left_node = nil, right_node = nil)
    @data = data
    @left_node = left_node
    @right_node = right_node
  end
end

class Tree
  attr_reader :root

  def initialize(arr = [])
    @root = self.build_tree(arr)
  end

  def build_tree(arr = [])
    arr = arr.sort().uniq()

    if arr == []
      return nil
    elsif arr.length == 1
      return Node.new(arr[0])
    else
      mid_index = (arr.length - 1)/2

      root_node = Node.new(arr[mid_index])
      root_node.left_node = self.build_tree(arr[0..(mid_index - 1)]) if mid_index > 0
      root_node.right_node = self.build_tree(arr[(mid_index + 1)..(arr.length - 1)])

      return root_node
    end
  end

  def insert(value, current_node = @root)
    if current_node == nil
      return Node.new(value)
    else
      if value < current_node.data
        current_node.left_node = insert(value, current_node.left_node)
      elsif value > current_node.data
        current_node.right_node = insert(value, current_node.right_node)
      end

      return current_node
    end
  end

  def delete(value)
    arr = self.inorder()
    arr = arr.filter { |i| i != value }
    @root = self.build_tree(arr)
  end

  def find(value, node_to_find = @root)
    if node_to_find.data == value || node_to_find == nil
      return node_to_find
    else
      return self.find(value, node_to_find.left_node) if value < node_to_find.data

      return self.find(value, node_to_find.right_node) if value > node_to_find.data
    end
  end

  def level_order(node = @root, result = [], queue = [node], &block)
    if node == nil && queue == []
      return result
    else
      dequeue_node = queue.shift()
      
      if block_given?
        result << block.call(dequeue_node.data)
      else
        result << dequeue_node.data
      end

      queue.push(dequeue_node.left_node) unless dequeue_node.left_node == nil
      queue.push(dequeue_node.right_node) unless dequeue_node.right_node == nil

      self.level_order(dequeue_node.left_node, result, queue, &block)      
    end
  end

  def inorder(node = @root, result = [], &block)
    unless node == nil
      self.inorder(node.left_node, result, &block)

      if block_given?
        result << block.call(node.data)
      else
        result << node.data
      end

      self.inorder(node.right_node, result, &block)
    end

    return result
  end

  def preorder(node = @root, result = [], &block)
    unless node == nil
      if block_given?
        result << block.call(node.data)
      else
        result << node.data
      end

      self.preorder(node.left_node, result, &block)

      self.preorder(node.right_node, result, &block)
    end

    return result
  end

  def postorder(node = @root, result = [], &block)
    return if node == nil

    self.postorder(node.left_node, result, &block)
    
    self.postorder(node.right_node, result, &block)

    if block_given?
      result << block.call(node.data)
    else
      result << node.data
    end

    return result
  end

  def height(node = @root, height = 0)
    return height if node == nil

    if (node.left_node == nil && node.right_node == nil)
      return height
    else
      height += 1
      left_height = self.height(node.left_node, height)
      right_height = self.height(node.right_node, height)

      left_height > right_height ? left_height : right_height
    end
  end

  def depth(node = @root)
    self.height(@root) - self.height(node)
  end

  def balanced?(node = @root)   
    if node == nil || (node.left_node == nil && node.right_node == nil)
      return true
    end
    
    left_height = self.height(node.left_node)
    right_height = self.height(node.right_node)
    if (left_height - right_height).abs > 1
      return false
    end

    return self.balanced?(node.left_node) && self.balanced?(node.right_node)
  end

  def rebalance()
    arr = self.inorder()
    @root = self.build_tree(arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end

# TEST
binary_tree = Tree.new(Array.new(15) { rand(1..100) })
binary_tree.pretty_print()

puts "Is binary tree balanced? #{binary_tree.balanced?}"

puts "Preorder"
p binary_tree.preorder()
puts "Postorder"
p binary_tree.postorder()
puts "Inorder"
p binary_tree.inorder()

print "\n"
puts "Unbalance binary tree by insert numbers > 100"

binary_tree.insert(150)
binary_tree.insert(200)
binary_tree.insert(300)

binary_tree.pretty_print()

puts "Is binary tree balanced? #{binary_tree.balanced?}"

print "\n"
puts "Rebalance binary tree..."

binary_tree.rebalance()

binary_tree.pretty_print()

puts "Is binary tree balanced? #{binary_tree.balanced?}"

puts "Preorder"
p binary_tree.preorder()
puts "Postorder"
p binary_tree.postorder()
puts "Inorder"
p binary_tree.inorder()


