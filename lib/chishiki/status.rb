module Chishiki
  class Status < Label
    def initialize(msg)
      super(Pos.new(0,$window.h - 1,0,0),
            %Q["#{msg} written"],
            WHITE)
    end

    def draw
      mvwaddstr stdscr, @pos.y, @pos.x, @msg
    end

    def move(y)
    end
  end
end
