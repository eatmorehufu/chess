require 'byebug'
class Board

  attr_reader :board, :castling

  BOARD_SIZE = 8
  BACK_ROW = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  FRONT_ROW = [Pawn] * BOARD_SIZE
  KING_START = 4
  ROOK_START = [0,7]
  BLACK_BACK_RANK = 0
  WHITE_BACK_RANK = 7

  def self.create_new_board
    Board.new.set_pieces
  end

  def self.in_bounds?(pos)
    pos.all? { |coord| (0...BOARD_SIZE).include?(coord) }
  end

  def initialize
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    @castling = {
      :black => {:king_side => true, :queen_side => true},
      :white => {:king_side => true, :queen_side => true}
    }
  end

  def set_pieces
    fill_row(0, :black, BACK_ROW)
    fill_row(1, :black, FRONT_ROW)
    fill_row(6, :white, FRONT_ROW)
    fill_row(7, :white, BACK_ROW)

    self
  end

  def [](pos)
    @board[pos.first][pos.last]
  end

  def []=(pos, value)
    @board[pos.first][pos.last] = value
  end

  def move(start_pos, end_pos)
    if !self[start_pos].valid_moves.include?(end_pos)
      raise InvalidMoveError.new("Can't move there.")
    end
    if self[start_pos].class == Rook || self[start_pos].class == King
      toggle_castle(start_pos)
    end
    move!(start_pos, end_pos)
  end

  def move!(start_pos, end_pos)
    piece = self[start_pos]

    piece.move_to(end_pos)
  end

  def occupied?(pos)
    !self[pos].nil?
  end

  def occupied_by_ally?(pos, color)
    occupied?(pos) && self[pos].color == color
  end

  def occupied_by_enemy?(pos, color)
    occupied?(pos) && self[pos].color != color
  end

  def in_check?(color)
    king_coords = pieces(color).find do |piece|
      piece.is_a?(King)
    end.pos

    opposing_pieces = color == :white ? pieces(:black) : pieces(:white)

    opposing_pieces.any? do |piece|
      piece.moves.include?(king_coords)
    end
  end

  def check_mate?(color)
    in_check?(color) && no_valid_moves?(color)
  end

  def draw?(color)
    !in_check?(color) && no_valid_moves?(color)
  end

  def dup
    dup_board = Board.new
    BOARD_SIZE.times do |rank_index|
      BOARD_SIZE.times do |file_index|
        dup_pos = [rank_index, file_index]
        next if self[dup_pos].nil?
        self[dup_pos].dup(dup_board)
      end
    end

    dup_board
  end

  def clear_castle_path?(color, side)
    if color == :white
      if side == :queen
        1.upto(KING_START - 1) do |file|
          return false if !self[[WHITE_BACK_RANK, file]].nil?
        end
      elsif side == :king
        (KING_START + 1).upto(BOARD_SIZE - 2) do |file|
          return false if !self[[WHITE_BACK_RANK, file]].nil?
        end
      end
    elsif color == :black
      if side == :queen
        1.upto(KING_START - 1) do |file|
          return false if !self[[BLACK_BACK_RANK, file]].nil?
        end
      elsif side == :king
        (KING_START + 1).upto(BOARD_SIZE - 2) do |file|
          return false if !self[[BLACK_BACK_RANK, file]].nil?
        end
      end
    end

    true
  end

  private



  def pieces(color)
    board.flatten.compact.select do |piece|
      piece.color == color
    end
  end

  def fill_row(rank, color, piece_order)
    BOARD_SIZE.times do |file|
      piece_order[file].new(self, color, [rank,file])
    end

    nil
  end

  def no_valid_moves?(color)
    pieces(color).all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def toggle_castle(pos)
    return nil if castling.all? { |k, v| v == false }
    if pos.last == ROOK_START[0]
      castling[:black][:queen_side] = false if pos.first == BLACK_BACK_RANK
      castling[:white][:queen_side] = false if pos.first == WHITE_BACK_RANK
    elsif pos.last == ROOK_START[1]
      castling[:black][:king_side] = false if pos.first == BLACK_BACK_RANK
      castling[:white][:king_side] = false if pos.first == WHITE_BACK_RANK
    elsif pos.last == KING_START
      if pos.first == BLACK_BACK_RANK
        castling[:black][:king_side] = false
        castling[:black][:queen_side] = false
      elsif pos.first == WHITE_BACK_RANK
        castling[:white][:queen_side] = false
        castling[:white][:king_side] = false
      end
    end


    nil
  end

end

class InvalidMoveError < StandardError
end
