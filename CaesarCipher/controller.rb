require_relative 'require'

FILENAME = 'text.txt'


class Controller

	def self.run(filename)
		@message = Message.create_new_message(filename)
		# encrypt
		decrypt
	end

	def self.encrypt(shift = [3, 8, 6, 9, 24, 7, 2, 19, 15, 18])
		@message.char_array = Shifter.shift_char_array(@message.char_array, shift)
		@message.save_text
		View.clear_screen
		@message.display
	end

	def self.decrypt
		shifts = Solver.finding_shifts(@message)
		encrypt(shifts)
	end



end



Controller.run(FILENAME)
# my_controller.display_message



