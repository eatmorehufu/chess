class King < SteppingPiece

  def deltas
    default_deltas = SteppingPiece::KING_DELTAS

    if board.castling[color][:king_side] == true &&
      board.clear_castle_path?(color, :king)
      default_deltas << [0,2]
    elsif board.castling[color][:queen_side] == true &&
      board.clear_castle_path?(color, :queen)
      default_deltas << [0,-3]
    end

    default_deltas
  end

  def inspect
    "#{color.to_s[0]}K "
  end

end
