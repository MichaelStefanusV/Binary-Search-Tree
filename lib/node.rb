# frozen_string_literal: true

# lib/node.rb

class Node
  attr_accessor :left, :right, :value

  def initialize(value)
    @left = nil
    @right = nil
    @value = value
  end

  def is_leaf?
    true if @left.nil? && @right.nil?
    false
  end
end
