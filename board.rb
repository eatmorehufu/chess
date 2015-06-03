require 'byebug'
class Board

  BOARD_SIZE = 8
  BACK_ROW = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  FRONT_ROW = [Pawn] * BOARD_SIZE

  def self.create_new_board
    Board.new.set_pieces
  end

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def set_pieces
    fill_row(0, :black, BACK_ROW)
    fill_row(1, :black, FRONT_ROW)
    fill_row(6, :white, FRONT_ROW)
    fill_row(7, :white, BACK_ROW)

    self
  end

  def [](*pos)
    @board[pos.first][pos.last]
  end

  def []=(*pos, value)
    @board[pos.first][pos.last] = value
  end

  def in_check?(color)
    king_coords = pieces.select do |piece|
      piece.is_a?(King) && piece.color == color
    end.first.pos

    opposing_pieces = pieces.select do |piece|
      piece.is_a?(Piece) && piece.color != color
    end

    opposing_pieces.any? do |piece|
        piece.moves.include?(king_coords)
    end
  end

  def move(start_pos, end_pos)
    piece = self[*start_pos]
    if piece.nil?
      raise NoPieceError.new("No piece to move.")
    elsif !piece.valid_moves.include?(end_pos)
      raise InvalidMoveError.new("Can't move there.")
    end

    piece.move_to(end_pos)
  end

  def move!(start_pos, end_pos)
    piece = self[*start_pos]
    raise NoPieceError if piece.nil?
    raise InvalidMoveError unless piece.moves.include?(end_pos)

    piece.move_to(end_pos)
  end

  def dup
    dup_board = Board.new
    BOARD_SIZE.times do |rank_index|
      BOARD_SIZE.times do |file_index|
        dup_pos = [rank_index, file_index]
        next if self[*dup_pos].nil?
        dup_board[*dup_pos] = self[*dup_pos].dup(dup_board)
      end
    end

    dup_board
  end

  def check_mate?(color)
    return false if !in_check?(color)

    pieces.select do |piece|
      piece.color == color
    end.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  private

  def pieces
    @board.flatten.compact
  end

  def fill_row(rank, color, piece_order)
    BOARD_SIZE.times do |file|
      self[rank, file] = piece_order[file].new(self, color, [rank,file])
    end

    nil
  end

end


class NoPieceError < StandardError
end

class InvalidMoveError < StandardError
end
