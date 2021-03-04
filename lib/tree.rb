# frozen_string_literal: true

# lib/tree.rb

require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(arr)
    @arr = arr.uniq.sort
    @root = build_tree(@arr)
  end

  def build_tree(arr)
    return nil if arr.empty?

    middle = (arr.size - 1) / 2
    root = Node.new(arr[middle])

    root.left = build_tree(arr[0...middle])
    root.right = build_tree(arr[(middle + 1)..-1])

    root
  end

  def insert(root, value)
    if root.nil?
      root = Node.new(value)
      return root
    end

    if value < root.value
      root.left = insert(root.left, value)
    elsif value > root.value
      root.right = insert(root.right, value)
    end
    root
  end

  def is_empty?(root)
    return true if root.nil?

    false
  end

  def inorder(root)
    if is_empty?(root) != true
      inorder(root.left)
      puts "#{root.value} "
      inorder(root.right)
    end
  end

  def preorder(root)
    if is_empty?(root) != true
      puts "#{root.value} "
      inorder(root.left)
      inorder(root.right)
    end
  end

  def postorder(root)
    if is_empty?(root) != true
      inorder(root.left)
      inorder(root.right)
      puts "#{root.value} "
    end
  end

  def min_value(root)
    minv = root.value
    until root.left.nil?
      minv = root.left.value
      root = root.left
    end
    minv
  end

  def delete(root, value)
    if is_empty?(root) == true
      return nil
      puts 'The tree is already empty!'
    end

    if value < root.value
      root.left = delete(root.left, value)
    elsif value > root.value
      root.right = delete(root.right, value)
    else

      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end

      root.value = min_value(root.right)
      root.right = delete(root.right, root.value)
    end
    root
  end

  def all_nil?(arr)
    result = true
    arr.each do |elem|
      result = false if elem.nil? == false
    end
    result
  end

  def level_order(root)
    if is_empty?(root) == true
      return nil
      puts 'The tree is empty!'
    end
    arr = []
    queue = []
    queue << root
    while all_nil?(queue) == false
      current = queue[0]
      next if current.nil?

      puts "#{current.value} "
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
      arr << queue.shift.value
    end
    arr
  end

  def max(a, b)
    if a > b
      a
    else
      b
    end
  end

  def height(root)
    if is_empty?(root) == true || root.is_leaf?
      return 0
      puts 'The tree is empty!'
    end

    max(height(root.left), height(root.right)) + 1
  end

  def balance
    root = @root
    differ =  height(root.left) - height(root.right)
    if differ >= -1 && differ <= 1
      true
    else
      false
    end
  end

  def depth(root, value)
    if is_empty?(root) == true
      return 0
      puts 'The tree is empty!'
    end
    count = 0
    if value < root.value
      count += 1 + depth(root.left, value)
    elsif value > root.value
      count += 1 + depth(root.right, value)
    else
      count
    end
    count
  end

  def rebalance
    @arr = level_order(@root)
    @arr = @arr.uniq.sort
    puts 'Isi arr'
    @root = build_tree(@arr)
  end
end

tree = Tree.new([1, -2, 3, 100, 200, 12])
tree.insert(tree.root, 3)
puts 'inorder'
puts tree.inorder(tree.root)
puts 'depth'
puts tree.depth(tree.root, 100)
puts 'height'
puts tree.height(tree.root.left)
puts 'level order'
puts tree.level_order(tree.root)
puts 'preorder'
puts tree.preorder(tree.root)
puts 'postorder'
puts tree.postorder(tree.root)
puts 'balance'
puts tree.balance
tree.insert(tree.root, 300)
tree.insert(tree.root, 3000)
tree.insert(tree.root, 30_000)
tree.insert(tree.root, 300_000)
tree.insert(tree.root, 3_000_000)
tree.insert(tree.root, 30_000_000)
tree.insert(tree.root, 300_000_000)
puts 'balance'
puts tree.balance
puts 'rebalance'
tree.rebalance
puts 'balance'
puts tree.balance
