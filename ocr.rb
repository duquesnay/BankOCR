class Ocr

  DIGIT_ZERO = ' _ | ||_|'
  DIGIT_ONE = '     |  |'
  DIGIT_TWO = ' _  _||_ '
  DIGIT_THREE = ' _  _| _|'
  DIGIT_FOUR = '   |_|  |'
  DIGIT_FIVE = ' _ |_  _|'
  DIGIT_SIX = ' _ |_ |_|'
  DIGIT_SEVEN = ' _   |  |'
  DIGIT_EIGHT = ' _ |_||_|'
  DIGIT_NINE = ' _ |_| _|'
  DIGIT_MATRIX = {
      DIGIT_ZERO => '0',
      DIGIT_ONE => '1',
      DIGIT_TWO => '2',
      DIGIT_THREE => '3',
      DIGIT_FOUR => '4',
      DIGIT_FIVE => '5',
      DIGIT_SIX => '6',
      DIGIT_SEVEN => '7',
      DIGIT_EIGHT => '8',
      DIGIT_NINE => '9'
  }

  NO_NUMBER = '?'

  def decode input
    raise "cannot parse empty line" if input.include? nil
    return Array.new if input.length<4

    results=[]

    nb_lines = input.size/4
    (0..nb_lines-1).each { |i|
      record = input[i*4..i*4+2]
      results[i]=decode_record record
    }

    return results
  end

  def decode_record(line_group)
    (0..8).collect { |caret|
      digit=line_group.collect { |l| l[caret*3..caret*3+2] }.join
      (DIGIT_MATRIX[digit] || NO_NUMBER)
    }.join
  end

end