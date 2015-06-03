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

        break if @board.check_mate?(@turn)

        @turn = @turn == :white ? :black : :white

      rescue InvalidMoveError => err
        puts err.message
        retry
      end
    end

    puts @turn == :white ? "White wins!" : "Black wins!"

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
        print " "
      elsif tile.color == :white
        print WHITE_PIECES[tile.class]
      else
        print BLACK_PIECES[tile.class]
      end
    end

    puts SIDE_FRAME[rank]
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
