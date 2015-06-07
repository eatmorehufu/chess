require 'byebug'

class Piece

attr_reader :color, :pos, :board

  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
    @board[pos] = self
  end

  def moves
    raise NotImplementedError
  end

  def move_to(new_pos)
    @board[pos] = nil
    @pos = new_pos
    @board[new_pos] = self
  end

  def dup(dup_board)
    self.class.new(dup_board, color, @pos.dup)
  end

  def move_into_check?(end_pos)
    dup_board = @board.dup
    dup_board.move!(@pos, end_pos)
    dup_board.in_check?(@color)
  end

  def valid_moves
    moves.select { |move| !move_into_check?(move) }
  end

  def can_promote?
    false
  end

end
