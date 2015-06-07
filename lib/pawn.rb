require 'byebug'
class Pawn < Piece

  attr_accessor :direction

  def initialize(board, color, pos)
    super
    @direction = color == :white ? :up : :down
  end

  def moves
    attackable_coords + marchable_coords + en_passant_coords
  end

  def inspect
    "#{color.to_s[0]}P "
  end

  def dup(dup_board)
    new_pawn = Pawn.new(dup_board, @color, @pos)

    new_pawn
  end

  def can_promote?
    opp_color = color == :white ? :black : :white
    return false if pos.first != Board::BACK_RANK[opp_color]
    true
  end

  private

  def attackable_coords
    attackable = []
    attack_deltas.each do |attack_coord|

      test_coord = [
        attack_coord.first + @pos.first,
        attack_coord.last + @pos.last
      ]

      if Board.in_bounds?(test_coord) &&
          @board.occupied_by_enemy?(test_coord, @color)
        attackable << test_coord
      end
    end

    attackable
  end

  def marchable_coords
    marchable = []

    steps = Board::FRONT_RANK.values.include?(@pos[0]) ? 2 : 1

    steps.times do |step|
      test_coord = [
        @pos.first + (march_delta.first * (step + 1)),
        @pos.last
      ]
      break if @board.occupied?(test_coord) ||
        !Board.in_bounds?(test_coord)
      marchable << test_coord
    end

    marchable
  end

  def march_delta
    @direction == :up ? [-1, 0] : [1, 0]
  end

  def attack_deltas
    if @direction == :up
      [[-1, -1], [-1, 1]]
    else
      [[1, -1], [1, 1]]
    end
  end

  def en_passant_coords
    return [] if @board.en_passant == nil
    [@board.en_passant]
  end

end
