require_relative 'require'

class View 
	def self.clear_screen
		puts "\e[H\e[2J"
	end 
end 