module Chishiki
  class Label 
    def initialize(pos, msg, col)
      @pos = pos
      @msg = msg
      @color = col
    end

    def draw
      attr_set A_NORMAL, @color, nil
      if @pos.y > Form.nlo
        @pos.y += Form.nlo_dir
      end
      mvwaddstr stdscr, @pos.y + Form.os.y, @pos.x + Form.os.x, @msg
    end
    def draw_abs
      mvwaddstr stdscr, @pos.y, @pos.x, @msg
    end
  end
end
