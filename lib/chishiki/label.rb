module Chishiki
  class Label 
    def initialize(pos, msg)
      @pos = pos
      @msg = msg
    end

    def draw
      mvwaddstr stdscr, @pos.y, @pos.x, @msg
    end
  end
end
