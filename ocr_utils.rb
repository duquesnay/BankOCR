module OcrUtils

  DIGIT_ONE = '     |  |'
  DIGIT_ZERO = ' _ | ||_|'
  DIGIT_TWO = ' _  _||_ '
  DIGIT_THREE = ' _  _| _|'
  DIGIT_FOUR = '   |_|  |'
  DIGIT_FIVE = ' _ |_  _|'
  DIGIT_SIX = ' _ |_ |_|'
  DIGIT_SEVEN = ' _   |  |'
  DIGIT_EIGHT = ' _ |_||_|'
  DIGIT_NINE = ' _ |_| _|'
  BLANK = '   '
  EMPTY_LINE = BLANK*9
  EMPTY_DIGIT = BLANK*3
  EMPTY_RECORD = [EMPTY_LINE]*4

  def show_input(input)
    puts "decoding \n---- "
    input.each { |l| puts l }
    puts "-- #{input.size} lines --"
    puts "----"
  end

  def wrap_stuff(encoded_stuff)
    digits_to_record(encoded_stuff) << EMPTY_LINE
  end

  def extend_record(digit, nb_digits)
    extend_digit(digit, nb_digits) << EMPTY_LINE
  end

  def extend_digit(digit, nb_digits)
    extend_digits([digit], nb_digits)
  end

  def extend_digits(digits, nb_digits)
    digits_to_record(digits << (  EMPTY_DIGIT*nb_digits))
  end

  def digits_to_record(digits)
    (0..2).collect { |i| digits.collect { |d| d[i*3..i*3+2] }.join }
  end
end