require "test/unit"
require 'minitest/reporters'
require './ocr.rb'
require './ocr_utils.rb'

# MiniTest::Unit.runner.reporters << MiniTest::Reporters::RubyMineReporter.new

class OcrTest < Test::Unit::TestCase
  include OcrUtils
  @ocr

  def setup
    @ocr=Ocr.new
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end


  def test_should_provide_exact_number_of_numbers_when_input_lines_are_complete
    #G
    input=[EMPTY_LINE]*196
    #W
    numbers=@ocr.decode input
    #T
    assert_equal 49, numbers.size
  end

  def test_should_provide_minimum_number_of_results_when_input_lines_not_sufficient
    #G
    input=[EMPTY_LINE]*195
    #W
    numbers=@ocr.decode input
    #T
    assert_equal 48, numbers.size
  end

  def test_should_decode_first_digit_first_line_when_0
    #g
    input=extend_record(DIGIT_ZERO, 8)
    #w
    numbers=@ocr.decode input
    #t
    assert_equal '0', numbers[0][0]
  end

  def test_return_nothing_when_not_enough_input
    assert_empty @ocr.decode []
  end

  def test_should_decode_first_digit_first_line_when_1
    #g
    input=extend_record(DIGIT_ONE, 8)
    #w
    numbers=@ocr.decode input
    #t
    assert_equal '1', numbers[0][0]
  end

  def test_should_decode_second_digit_first_line_when_1
    #g
    nb_digits = 7
    record = [EMPTY_DIGIT, DIGIT_ONE, EMPTY_DIGIT, EMPTY_DIGIT, EMPTY_DIGIT, EMPTY_DIGIT, EMPTY_DIGIT, EMPTY_DIGIT, EMPTY_DIGIT, EMPTY_DIGIT]
    puts "decoding '#{record}'"
    input= wrap_stuff(record)

    #w
    numbers=@ocr.decode input

    #t
    assert_equal '1', numbers[0][1]
  end

  def test_should_decode_all_digits_on_first_line
    zero_line = [DIGIT_ZERO]*9
    input=wrap_stuff(zero_line)
    numbers=@ocr.decode input
    assert_equal '000000000', numbers[0]
  end

  def test_should_decode_3_to_9_numbers
    encoded_stuff = [DIGIT_ONE, DIGIT_TWO, DIGIT_THREE, DIGIT_FOUR, DIGIT_FIVE, DIGIT_SIX, DIGIT_SEVEN, DIGIT_EIGHT, DIGIT_NINE]
    input = wrap_stuff(encoded_stuff)

    puts "decoding \n----\n"
    input.each { |l| puts l }
    assert_equal "123456789", (@ocr.decode input)[0]
  end

  def test_should_decode_second_line
    #g
    encoded_stuff = [DIGIT_ONE, DIGIT_TWO, DIGIT_THREE, DIGIT_FOUR, DIGIT_FIVE, DIGIT_SIX, DIGIT_SEVEN, DIGIT_EIGHT, DIGIT_NINE]
    input = EMPTY_RECORD + wrap_stuff(encoded_stuff)

    show_input(input)

    #w
    results=@ocr.decode input
    #t
    assert_equal "123456789", results[1]
  end

  def test_should_decode_even_the_99th_line
    encoded_stuff = [DIGIT_ONE, DIGIT_TWO, DIGIT_THREE, DIGIT_FOUR, DIGIT_FIVE, DIGIT_SIX, DIGIT_SEVEN, DIGIT_EIGHT, DIGIT_NINE]
    input = (EMPTY_RECORD*95) + wrap_stuff(encoded_stuff)

    #w
    results=@ocr.decode input
    #t
    assert_equal "123456789", results[95]
  end

  def test_should_raise_when_empty_line
    assert_raises(RuntimeError) {
      @ocr.decode([nil])
    }
  end


end