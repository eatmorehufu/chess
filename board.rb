require_relative 'pieces.rb'
require_relative 'chess.rb'

class Board
  BOARD_SIZE = 8

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def set_pieces
    @board.each_with_index do |rank, rank_index|
      case rank_index
      when 0
        set_powers(rank_index, :black)
      when 1
        set_pawns(rank_index, :black)
      when 6
        set_pawns(rank_index, :white)
      when 7
        set_pawns(rank_index, :white)
      end
    end
  end

  def set_pawns(rank_index, color)
    BOARD_SIZE.times do |file_index|
      pos = [rank_index, file_index]
      self[*pos] = Pawn.new(self, color, pos)
    end
  end

  def set_powers(rank_index, color)
    BOARD_SIZE.times do |file_index|
      pos = [rank_index, file_index]
      case file_index
      when 0, 7
        self[*pos] = Rook.new(self, color, pos)
      when 1, 6
        self[*pos] = Knight.new(self, color, pos)
      when 2, 5
        self[*pos] = Bishop.new(self, color, pos)
      when 3
        self[*pos] = Queen.new(self, color, pos)
      when 4
        self[*pos] = King.new(self, color, pos)
      end
    end
  end

  def [](*pos)
    @board[pos.first][pos.last]
  end

  def []=(*pos, value)
    @board[pos.first][pos.last] = value
  end

end
