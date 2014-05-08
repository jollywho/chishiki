module Chishiki
  class Pipe
    def initialize(pos, cib)
      @msg = "|"
      @amount = cib
      @pos = pos
    end

    def render(y)
      attr_set A_NORMAL, 1, nil
      mvwaddstr stdscr, @pos.y + Form.os.y - y, @pos.x + Form.os.x, @msg
    end

    def draw
      if @pos.y > Form.nlo
        @pos.y += Form.nlo_dir
      end
      @amount.times {|x| render x}
    end
  end
end
