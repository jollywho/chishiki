module Chishiki
  class Form
    def initialize
      @list = []
      win = getmaxyx stdscr
      @window = Pos.new(0,0,win[1],win[0])
      @center = Pos.new(
        @window.w/2.0 - 40/2.0,
        @window.h/2.0 - 1/2.0)
      @focus = Branch.new(nil, @center.dup)
    end

    def update(ch)
      if ch == 6 # ^f
        remove(@focus)
        clear
      elsif ch == 7 # ^g
      else
        @focus.handle_key ch
      end
      $log.debug @focus.object_id
    end

    def draw
      @focus.draw
    end

    def self.offset
      @@offset
    end

  end
end
