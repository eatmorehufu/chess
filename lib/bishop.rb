class Bishop < SlidingPiece

  def move_dirs
    SlidingPiece::BISHOP_DELTAS
  end

  def inspect
    "#{color.to_s[0]}B "
  end

end
