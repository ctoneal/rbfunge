require File.expand_path(File.join(File.dirname(__FILE__), "memory_stack.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "program.rb"))

module Rbfunge
	class Interpreter
	
		def initialize
			@program = Program.new
			@memory = Memory_Stack.new
			@string_mode = false
			@commands = {
				'+' => :add,
				'-' => :subtract,
				'*' => :multiply,
				'/' => :divide,
				'%' => :mod,
				'!' => :not,
				'`' => :greater_than,
				'>' => :move_right,
				'<' => :move_left,
				'^' => :move_up,
				'v' => :move_down,
				'?' => :move_random,
				'_' => :horizontal_if,
				'|' => :vertical_if,
				'"' => :toggle_string_mode,
				':' => :duplicate,
				'\\' => :swap,
				'$' => :pop,
				'.' => :output_int,
				',' => :output_ascii,
				'#' => :trampoline,
				'p' => :put,
				'g' => :get,
				'&' => :input_int,
				'~' => :input_ascii,
				'@' => :quit,
				' ' => :noop,				
			}
		end
		
		def run(code)
			@program.load_code(code)
			catch :quit do
				while true
					evaluate_instruction(@program.get_current.chr)
					@program.move
				end
			end
		end
		
		def evaluate_instruction(instruction)
			if @string_mode and @commands[instruction] != :toggle_string_mode
				@memory.push instruction
			elsif ("0".."9").include? instruction
				@memory.push instruction.to_i
			else
				if @commands.has_key? instruction
					send @commands[instruction]
				else
					raise "Invalid instruction: #{instruction}"
				end
			end
		end
		
		def add
			a = @memory.pop
			b = @memory.pop
			value = b + a
			@memory.push value
		end
		
		def subtract
			a = @memory.pop
			b = @memory.pop
			value = b - a
			@memory.push value
		end
		
		def multiply
			a = @memory.pop
			b = @memory.pop
			value = b * a
			@memory.push value
		end
		
		def divide
			a = @memory.pop
			b = @memory.pop
			value = b / a
			@memory.push value
		end
		
		def mod
			a = @memory.pop
			b = @memory.pop
			value = b % a
			@memory.push value
		end
		
		def not
			@memory.push(@memory.pop == 0 ? 1 : 0)
		end
		
		def greater_than
			a = @memory.pop
			b = @memory.pop
			@memory.push(b > a ? 1 : 0)
		end
		
		def move_right
			@program.direction = :right
		end
		
		def move_left
			@program.direction = :left
		end
		
		def move_up
			@program.direction = :up
		end
		
		def move_down
			@program.direction = :down
		end
		
		def move_random
			dir = [:right, :left, :up, :down]
			@program.direction = dir[rand(dir.size)]
		end
		
		def horizontal_if
			@program.direction = (@memory.pop == 0) ? :right : :left
		end
		
		def vertical_if
			@program.direction = (@memory.pop == 0) ? :down : :up
		end
		
		def toggle_string_mode
			@string_mode = !@string_mode
		end
		
		def duplicate
			@memory.dup
		end
		
		def swap
			@memory.swap
		end
		
		def pop
			@memory.pop
		end
		
		def output_int
			print @memory.pop.to_i
		end
		
		def output_ascii
			print @memory.pop.chr
		end
		
		def trampoline
			@program.move
		end
		
		def put
			y = @memory.pop
			x = @memory.pop
			@program.put(x, y, @memory.pop)
		end
		
		def get
			y = @memory.pop
			x = @memory.pop
			@memory.push(@program.get(x, y))
		end
		
		def input_int
			@memory.push(gets.to_i)
		end
		
		def input_ascii
			@memory.push(gets[0])
		end
		
		def quit
			puts "Exiting..."
			throw :quit
		end
		
		def noop
		end
	end
end