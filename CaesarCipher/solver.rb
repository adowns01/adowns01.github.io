require_relative 'require'


class Solver
  attr_accessor :text_array


  def self.find_most_freq_letter(character_frequency)
    most_feq_letter = character_frequency.max_by{|letter, freq| freq}.first
  end

  def self.downcase_array(text_array)
    text_array.map{|char| char.downcase}
  end

  def self.finding_repeat(message)
    all_freqs = []
    7.times {|i| all_freqs << find_char_freqs(message, i+1)}
    return find_shifts(all_freqs)
  end 


  def self.find_char_freqs(message, repeat = 1)
    char_freqs = []
    count = 0

    char_array = downcase_array(message.char_array)
    
    while count < repeat
      location = 0
      character_frequency = set_up_char_freq
      num_letters = 0

      while location < char_array.length
        char = char_array[location]


        if letter?(char) && num_letters % repeat == count
          character_frequency[char] += 1
          location += 1
          # puts "added '#{char}'"
        else
          location += 1
        end 
        num_letters += 1 if letter?(char)
      end

      count += 1
      char_freqs << character_frequency
    end 
    
    p char_freqs.length
    return char_freqs
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

  def self.find_shifts(all_freqs)
    repeat_length = find_repeat_length(all_freqs)
    freqs = all_freqs[repeat_length -1]
    freqs.map! do |char_freq|
      determine_shift_to_e(char_freq)
    end 
    p freqs
  end 



  def self.determine_shift_to_e(char_freq)
    e_ascii = "e".ord
    letter_ascii = find_most_freq_letter(char_freq).ord
    shift = e_ascii - letter_ascii
    return shift
  end

  def self.find_most_freq_letter(char_freq)
    char_freq.max_by{|letter, freq| freq}.first
  end
 

  def self.find_repeat_length(all_freqs)
    repeat_length = nil
    max_percentage = 0


    all_freqs.each do |char_freq_per_repeat|
      char_freq_per_repeat.each do |each_hash|


        sum = calculate_sum(each_hash)
        each_hash.each do |key, value|
          percentage = ((value.to_f)/(sum.to_f)*100).to_i
          if percentage > max_percentage
            max_percentage = percentage
            repeat_length = char_freq_per_repeat.length
          end
        end 

      end 

    end 

    # puts "repeat: #{repeat}"
    return repeat_length
  end 

  def self.calculate_sum(data)
    sum = 0
    data.each do |key, value|
      sum += value
    end 
    return sum
  end



  def self.print_char_freqs(char_freqs)
    char_freqs.each do |char_freq_per_repeat| 
      char_freq_per_repeat.each do |char_freq|

        Histogram.new(char_freq)
        puts "repeat: #{char_freq_per_repeat.length}"
        sleep(2)
      end 
    end 
  end 

end