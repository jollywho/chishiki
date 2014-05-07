module Chishiki
  class Pipe
    def initialize(pos, cib)
      @msg = "|"
      @amount = cib
      @pos = pos
    end

    def render(y)
      mvwaddstr stdscr, @pos.y + Form.os.y - y, @pos.x + Form.os.x, @msg
    end

    def draw
      $log.debug @amount
      @amount.times {|x| render x}
    end
  end
end