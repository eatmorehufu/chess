class Game

  def self.notation_lookup
    hash = Hash.new
    ("A".."H").each_with_index do |letter, file|
      (1..8).to_a.reverse.each_with_index do |num, rank|
         hash[letter + num.to_s] = [rank,file]
      end
    end

    hash
  end

  CHESS_NOTATION = self.notation_lookup

  WHITE_PIECES = {
    King => "♔",
    Queen => "♕",
    Rook => "♖",
    Bishop => "♗",
    Knight => "♘",
    Pawn => "♙"
  }

  BLACK_PIECES = {
    King => "♚",
    Queen => "♛",
    Rook => "♜",
    Bishop => "♝",
    Knight => "♞",
    Pawn => "♟"
  }

  def initialize
    @board = Board.create_new_board
    @turn = :white
  end

  def play
    white = HumanPlayer.new(:white, @board)
    black = HumanPlayer.new(:black, @board)
    draw_board

    loop do
      begin
        puts "#{@turn.to_s.capitalize}'s turn"
        input = @turn == :white ? white.play_turn : black.play_turn
        error_check(input)
        @board.move(*input)
        draw_board

        @turn = @turn == :white ? :black : :white

        break if @board.check_mate?(@turn) || @board.draw?(@turn)

      rescue InvalidMoveError => err
        puts err.message
        retry
      end
    end
    if @board.draw?(@turn)
      puts "It's a draw!"
    else
      puts @turn == :black ? "White wins!" : "Black wins!"
    end

  end

  private

  TOP_FRAME = ("a".."h").to_a
  SIDE_FRAME = ("1".."8").to_a.reverse

  def draw_board
    puts " #{TOP_FRAME.join} "
    Board::BOARD_SIZE.times do |rank|
      print_line(rank)
    end
    puts " #{TOP_FRAME.join} "
  end

  def print_line(rank)
    print SIDE_FRAME[rank]

    Board::BOARD_SIZE.times do |file|
      tile = @board[rank, file]
      if tile.nil?
        print_with_background(" ", rank, file)
      elsif tile.color == :white
        print_with_background(WHITE_PIECES[tile.class], rank, file)
      else
        print_with_background(BLACK_PIECES[tile.class], rank, file)
      end
    end

    puts SIDE_FRAME[rank]
  end

  def print_with_background(char, rank, file)
    if (rank + file) % 2 == 0
      print char.colorize(:background => :light_white)
    else
      print char.colorize(:background => :white)
    end
  end

  def error_check(input)
    piece = @board[*input.first]

    if piece.nil?
      raise InvalidMoveError.new("No piece to move.")
    elsif piece.color != @turn
      raise InvalidMoveError.new("Not your piece to move.")
    elsif !piece.valid_moves.include?(input.last)
      raise InvalidMoveError.new("Can't move there.")
    end

    nil
  end


end
