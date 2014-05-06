module Chishiki
  class Pipe
    def initialize(pos, cib)
      @msg = "|"
      @amount = cib
      @pos = pos
    end
    def draw
      mvwaddstr stdscr, @pos.y + Form.os.y, @pos.x + Form.os.x, @msg
    end
  end
end
