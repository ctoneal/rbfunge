module Rbfunge
	# memory stack for Befunge programs
	class Memory_Stack
		
		# initialize the memory
		def initialize
			@stack = []
		end
		
		# pop the first top element off the stack
		def pop
			return @stack.empty? ? 0 : @stack.pop
		end
		
		# push an element onto the stack
		def push(value)
			@stack.push value
		end
		
		# swap the top two items in the stack
		def swap
			first = pop
			second = pop
			push first
			push second
		end
		
		# duplicate the top item
		def dup
			top = pop
			push top
			push top
		end
	end
end