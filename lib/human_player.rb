class HumanPlayer


  def initialize
  end

  def play_turn
    puts "Input a move (e.g. E2-E4)"
    input = gets.chomp.upcase

    if invalid_input?(input)
      raise InvalidSelectionError.new("Bad input format.")
    end

    start_pos = Game::CHESS_NOTATION[input[0..1]]
    end_pos = Game::CHESS_NOTATION[input[3..4]]

    [start_pos, end_pos]

  rescue InvalidSelectionError => error
    puts error.message
    retry

  end

private

  def invalid_input?(input)
    !/\A[A-H][1-8]-[A-H][1-8]\z/.match(input)
  end


end

class InvalidSelectionError < StandardError
end
