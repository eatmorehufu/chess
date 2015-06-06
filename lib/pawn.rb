require 'byebug'
class Pawn < Piece
  TOP_PAWN_RANK = 1
  BOTTOM_PAWN_RANK = 6

  attr_accessor :direction, :en_passant

  def initialize(board, color, pos)
    super
    @direction = find_direction(pos)
    @en_passant = false
  end

  def moves
    attackable_coords + marchable_coords
  end

  def inspect
    "#{color.to_s[0]}P "
  end

  def dup(dup_board)
    new_pawn = Pawn.new(dup_board, @color, @pos)
    new_pawn.direction = @direction
    new_pawn.en_passant = @en_passant

    new_pawn
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

    steps = @pos[0] == TOP_PAWN_RANK ||
      @pos[0] == BOTTOM_PAWN_RANK ? 2 : 1

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

  def find_direction(pos)
    pos.first == TOP_PAWN_RANK ? :down : :up
  end

end
