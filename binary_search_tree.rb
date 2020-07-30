class Node
	attr_accessor :data, :left, :right

	def initialize(data, left=nil, right=nil)
		@data = data
		@left = left
		@right = right
	end
end


class Tree
	attr_accessor :root

	def initialize(array)
		@array = array.uniq.sort!
		@root = build_tree(@array) unless array.nil?

	end

	def build_tree(array=@array)
		return if array.length < 1

		mid = (array.length - 1) / 2

		left = build_tree(array[0...mid])
		right = build_tree(array[(mid + 1)...array.length])
		root = Node.new(array[mid], left, right)
		
		return root
	end

	def insert(value, node=@root)
		return warn "Already exists" if @array.include?(value)
		
		if node.nil?
			@root = Node.new(value)
		elsif value < @root.data
			node.left = insert(value, node.left)
		else
			node.right = insert(value, node.right)
		end
	end

	def delete(value, node = @root)
		return warn "Not in tree" if !@array.include?(value)

		if value < node
			node.left = delete(value, node.left)
		elsif value > node
			node.right = delete(value, node.right)
		elsif node.left.nil? && node.right.nil?
			node = nil
		elsif node.left.nil?
			node = node.right
		elsif node.right.nil?
			node = node.left
		else
			#look at right nodes for next value
			#recursively make that value the new node and delete old iteration of that vlaue
			#likely need to build inorder traversal method to get proper value from right
			#then replace initial delete value, call delete on old iteration of that value
		end	
	end

	def find(value, node=@root)
		return "not found" if !@array.include?(value)

		if value == node.data
			return node
		elsif value < node.data
			find(value, node.left)
		else
			find(value, node.right)
		end
	end

	def level_order
	end

	def inorder
	end

	def preorder
	end

	def postorder
	end

	def depth
	end

	def balanced?
	end

	def rebalance
	end
end





#TESTING STUFF
my_array = [1, 2, 3, 5, 6, 7, 8, 9]

my_tree = Tree.new(my_array)

print my_tree.find(4)


