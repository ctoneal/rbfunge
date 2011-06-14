require File.expand_path(File.join(File.dirname(__FILE__), "rbfunge", "interpreter.rb"))

module Rbfunge
	# creates the interpreter and loads programs from files
	class Base
	
		# initialize the class
		def initialize
			@interpreter = Interpreter.new
		end
		
		# load a file and interpret it
		# currently, this is assuming Befunge-93 80x25 layout
		def load_file(file_path)
			code = File.open(file_path) { |f| f.read }
			@interpreter.run(code)
		end
	end
end