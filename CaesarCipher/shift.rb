require_relative 'require'

class Shifter

  def self.shift_char_array(char_array, shifts = [1])

    shift_loc = -1
    shifts_length = shifts.length

    char_array.map! do |char| 
      shift_loc = (shift_loc + 1) % shifts_length if letter?(char)
      shift_char(char, shifts[shift_loc])
    end

  end 

  def self.shift_char(char, shift)
    return char if !letter?(char)

    up_letters = ('A'..'Z').to_a
    low_letters = ('a'..'z').to_a

    if low_letters.include?(char)
      index = low_letters.index(char)
      shifted_index = (index + shift) % 26
      return low_letters[shifted_index]
    else
      index = up_letters.index(char)
      shifted_index = (index + shift) % 26
      return up_letters[shifted_index]
    end
  end 

  def self.letter?(char)
    letters = ('a'..'z').to_a
    return letters.include?(char.downcase)
  end 
end 


# p shift_char('S', 1) == 'T'
# p shift_char('a', 26) == 'a'
# char_array = %w(a a a a a a a a a)
# p Shifter.shift_char_array(char_array, [1,2,3, 4, 5])