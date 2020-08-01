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

	def insert(value, node = @root)
		return warn "Already exists" if (inorder().include?(value))
		
		if value < node.data
			if node.left
				insert(value, node.left)
			else
				node.left = Node.new(value)
			end
		elsif value > node.data
			if node.right
				insert(value, node.right)
			else
				node.right = Node.new(value)
			end
		end		
	end

	def delete(value, node = @root)
		return warn "Not in tree" if !(inorder().include?(value))

		if value < node.data
			node.left = delete(value, node.left)
		elsif value > node.data
			node.right = delete(value, node.right)
		
		#no children	
		elsif node.left.nil? && node.right.nil?
			node = nil
		
		#one child
		elsif node.left.nil?
			node = node.right
		elsif node.right.nil?
			node = node.left
		
		#two children
		else
			replacement = inorder(node.right)[0]

			delete(replacement)
			node.data = replacement
		end
		node
	end

	def find(value, node=@root)
		return "not found" if !(inorder().include?(value))

		if value == node.data
			return node
		elsif value < node.data
			find(value, node.left)
		else
			find(value, node.right)
		end
		return node
	end

	def levelorder(node=@root)
		queue = [node]
		output = []

		while !queue.empty?
			current = queue.shift
			output << current.data
			yield(current) if block_given?
			if current.left
				queue.push(current.left)
			end
			if current.right
				queue.push(current.right)
			end
		end
		return output
	end

	def inorder(node=@root, output = [])
		return if node.nil?

		inorder(node.left, output)
		output << node.data
		inorder(node.right, output)
		
		output
	end

	def preorder(node=@root, output = [])
		return if node.nil?

		output << node.data
		preorder(node.left, output)
		preorder(node.right, output)
		
		output
	end

	def postorder(node=@root, output = [])
		return if node.nil?

		postorder(node.left, output)
		postorder(node.right, output)
		output << node.data
		
		output
	end

	def depth(node=@root, counter=0)
		return counter if node.nil?

		left = depth(node.left, counter + 1)
		right = depth(node.right, counter + 1)

		left > right ? left : right
	end

	def balanced?
		left = depth(self.root.left)
		right = depth(self.root.right)

		(left - right).abs <= 1 ? true : false
	end

	def rebalance
		initialize(self.inorder)
	end
end

#driver script
my_array = (Array.new(15) { rand(1..100) })
my_tree = Tree.new(my_array)
puts "balanced?: " + my_tree.balanced?.to_s
puts "level order: " + my_tree.levelorder.to_s
puts "in order: " + my_tree.inorder.to_s
puts "pre order: " + my_tree.preorder.to_s
puts "postorder: " + my_tree.postorder.to_s
puts "inserting 101, 102, 103"
my_tree.insert(101)
my_tree.insert(102)
my_tree.insert(103)
puts "balanced?: " + my_tree.balanced?.to_s
puts "rebalancing"
my_tree.rebalance
puts "balanced?: " + my_tree.balanced?.to_s
puts "level order: " + my_tree.levelorder.to_s
puts "in order: " + my_tree.inorder.to_s
puts "pre order: " + my_tree.preorder.to_s
puts "postorder: " + my_tree.postorder.to_s