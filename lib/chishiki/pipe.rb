module Chishiki
  class Pipe
    attr_accessor :pos, :amount
    def initialize(pos, par, tar)
      @msg = CHAR_VPIPE
      @pos = pos
      @parent = par
      @target = tar
      @change = @target.cib
      @offset = @parent.leaf ? -1 : 0
      @amount = @change + @offset
      @color = 1
    end

    def render(y)
      attr_set A_NORMAL, @color, nil
      mvwaddstr(
        stdscr,
        @pos.y + Form.os.y - y,
        @pos.x + Form.os.x,
        @msg
      )
    end

    def set_color(col)
      @color = col
    end

    def swap_tar(tar, cib)
      @target = tar
      @amount = cib
    end

    def move(y)
      @pos.y += y
      if @pos.y >= Form.nlo && @target.pos.y < Form.nlo
        @amount += y
      end
    end

    def draw
      @amount.times {|x| render x}
    end
  end
end
