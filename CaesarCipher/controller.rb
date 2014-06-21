require_relative 'require'

FILENAME = 'text.txt'


class Controller

	def self.run(filename)
		@message = Message.create_new_message(filename)
		encrypt
		decrypt
	end

	def self.encrypt(shift = make_rand_shift)
		@message.char_array = Shifter.shift_char_array(@message.char_array, shift)
		@message.save_text
		View.clear_screen
		@message.display
	end

	def self.decrypt
		shifts = Solver.finding_shifts(@message)
		encrypt(shifts)
	end

	def self.make_rand_shift
		length = rand(1..MAX_REPEAT_LENGTH)
		shift = []
		length.times {|i| shift << rand(1..26)}
		puts "shift #{shift}"
		return shift 
	end 

end



Controller.run(FILENAME)
# my_controller.display_message



