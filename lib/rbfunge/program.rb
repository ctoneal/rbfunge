module Rbfunge
	class Program
	
		attr_accessor :direction
		
		def initialize
			@program = []
			@current_x = 0
			@current_y = 0
			@direction = :right
		end
		
		def load_code(code)
			line_array = code.split("\n")
			25.times do
				@program << pad_line(line_array.shift)
			end
		end
		
		def pad_line(line)
			if line.nil?
				padded_line = "".ljust(80)
			else
				padded_line = line[0..79].ljust(80)
			end
		end
		
		def move
			case @direction
			when :right
				@current_x = (@current_x + 1) % 80
			when :left
				@current_x = (@current_x - 1) % 80
			when :up
				@current_y = (@current_y - 1) % 25
			when :down
				@current_y = (@current_y + 1) % 25
			end
		end
		
		def get(x, y)
			@program[y][x]
		end
		
		def get_current
			get(@current_x, @current_y)
		end
		
		def put(x, y, value)
			@program[x][y] = value
		end
	end
end