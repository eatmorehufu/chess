class HumanPlayer

PROMOTIONS = %w(queen knight bishop rook)
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

  def get_promotion_choice
    puts "Promote your pawn! What would you like it to become? (e.g. queen)"
    input = gets.chomp.downcase
    unless PROMOTIONS.include?(input)
      raise InvalidSelectionError.new("Not a valid promotion choice.")
    end

    input.capitalize
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
