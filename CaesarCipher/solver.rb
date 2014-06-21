require_relative 'require'

MAX_REPEAT_LENGTH = 7

class Solver
  attr_accessor :text_array

  def self.finding_shifts(message, max_repeat_length = MAX_REPEAT_LENGTH)
    char_freqs_by_repeat_len = find_char_frequncies_at_different_intervals(message, max_repeat_length)
    
    repeat_length = find_repeat_length(char_freqs_by_repeat_len)
    valid_char_freqs = char_freqs_by_repeat_len[repeat_length -1]

    return find_shifts(valid_char_freqs)
  end 

  def self.find_char_frequncies_at_different_intervals(message, max_repeat_length)
    char_freqs_by_repeat_len = []
    max_repeat_length.times {|i| char_freqs_by_repeat_len << find_char_freqs(message, i+1)}
    return char_freqs_by_repeat_len
  end

  def self.find_shifts(char_freqs)
    char_freqs.map! do |char_freq|
      determine_shift_to_e(char_freq)
    end 
    char_freqs
  end 

  def self.determine_shift_to_e(char_freq)
    e_ascii = "e".ord
    letter_ascii = find_most_freq_letter(char_freq).ord
    shift = e_ascii - letter_ascii
    return shift
  end

  def self.find_most_freq_letter(character_frequency)
    most_feq_letter = character_frequency.max_by{|letter, freq| freq}.first
  end

  def self.downcase_array(text_array)
    text_array.map{|char| char.downcase}
  end


  def self.find_char_freqs(message, repeat)
    char_freqs_per_repeat = []
    starting_location = 0

    char_array = downcase_array(message.char_array)
    
    while starting_location < repeat
      char_freqs_per_repeat << find_char_freq_starting_at(starting_location, char_array, repeat)
      starting_location += 1
    end 
    
    return char_freqs_per_repeat
  end

   def self.find_char_freq_starting_at(starting_location, char_array, repeat)
      iter = 0
      char_freq = set_up_char_freq
      num_letters_checked = 0

      while iter < char_array.length
        char = char_array[iter]


        if valid_spot?(char, num_letters_checked, repeat, starting_location)
          char_freq[char] += 1
        end

        iter += 1
        num_letters_checked += 1 if letter?(char)
      end
      return char_freq
   end




  def self.valid_spot?(char, num_letters_checked, repeat, starting_location)
    return letter?(char) && num_letters_checked % repeat == starting_location
  end 

  def self.letter?(char)
    letters = ('a'..'z').to_a
    return letters.include?(char)
  end 

  def self.set_up_char_freq
    char_freq = {}
    letters = ('a'..'z').to_a
    letters.each{|letter| char_freq[letter] = 0}
    return char_freq
  end


  def self.find_most_freq_letter(char_freq)
    char_freq.max_by{|letter, freq| freq}.first
  end


  def self.find_repeat_length(all_char_freqs)
    repeat_length = nil
    max_percentage_sf = 0


    all_char_freqs.each do |char_freq_per_repeat_len|
      char_freq_per_repeat_len.each do |char_freq|
        sum = calculate_sum(char_freq)
        char_freq.each do |key, value|
          percentage = calculate_percentage(sum, value)
          if percentage > max_percentage_sf
            max_percentage_sf = percentage
            repeat_length = char_freq_per_repeat_len.length
          end
        end 
      end 
    end 
    return repeat_length
  end 


  def self.calculate_percentage(sum, value)
    ((value.to_f)/(sum.to_f)*100)
  end

  def self.calculate_sum(data)
    sum = 0
    data.each do |key, value|
      sum += value
    end 
    return sum
  end



  # def self.print_char_freqs(char_freqs)
  #   char_freqs.each do |char_freq_per_repeat| 
  #     char_freq_per_repeat.each do |char_freq|

  #       Histogram.new(char_freq)
  #       puts "repeat: #{char_freq_per_repeat.length}"
  #       sleep(2)
  #     end 
  #   end 
  # end 

end