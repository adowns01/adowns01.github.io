require_relative 'require'

class Message
	attr_accessor :char_array

	def initialize (filename)
		@filename = filename
		@char_array = read_in_chars		
	end 

	def read_in_chars
		char_array = []
		f = File.open(@filename, "r")
		f.each_line {|line| char_array += line.split("")}
		f.close
		return char_array
	end

	def save_text
		File.open(@filename, "w") do |file|
			file.puts @char_array.join("")
		end
	end

	def display
		f = File.open(@filename, "r")
		f.each_line {|line| puts line}
		f.close
	end

	def find_char_freq
		return Solver.find_char_freq(self)
	end

	def display_char_freq
		Histogram.new(@char_freq,5)
	end


	def self.create_new_message(filename)
		return Message.new(filename)
	end 

end 