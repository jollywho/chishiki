module Chishiki
  class Label 
    def initialize(pos, msg)
      @pos = pos
      @msg = msg
    end

    def draw
      mvwaddstr stdscr, @pos.y + Form.os.y, @pos.x + Form.os.x, @msg
    end
  end
end
