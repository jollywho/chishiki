module Chishiki
  class Pipe
    def initialize(pos, par, tar)
      @msg = "|"
      @pos = pos
      @parent = par
      @target = tar
      @change = @target.cib
      @offset = @parent.leaf ? -1 : 0
      @amount = @change + @offset
    end

    def render(y)
      attr_set A_NORMAL, 1, nil
      mvwaddstr stdscr, @pos.y + Form.os.y - y, @pos.x + Form.os.x, @msg
    end

    def move(y)
      @pos.y += y
      if @pos.y >= Form.nlo and @target.pos.y < Form.nlo
        @amount += y
      end
    end

    def draw
      @amount.times {|x| render x}
    end
  end
end
