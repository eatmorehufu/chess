class Rook < SlidingPiece

  def move_dirs
    SlidingPiece::ROOK_DELTAS
  end

  def inspect
    "#{color.to_s[0]}R "
  end

end
