module Chishiki
  class Label
    def initialize(pos, msg, col)
      @pos = pos
      @msg = msg
      @color = col
    end

    def set_msg(msg)
      @msg = msg
    end

    def draw
      attr_set A_NORMAL, @color, nil
      Renderer.draw(@pos.x, @pos.y, @msg)
    end

    def move(y)
      @pos.y += y
    end

    def draw_abs
      mvwaddstr stdscr, @pos.y, @pos.x, @msg
    end
  end
end
