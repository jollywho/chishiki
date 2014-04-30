module Chishiki
  class Form
    attr_accessor :list
    def initialize
      @list = []
      win = getmaxyx stdscr
      @window = Pos.new(0,0,win[1],win[0])
      add Text.new(
        :pos => @window)
      center
      set_focus(@focus)
    end

    def add(widget)
      @list.push widget
      @focus = widget
    end

    def remove(widget)
      @list.delete_at(@list.index(widget))
    end

    def update(ch)
      if ch == 6
        remove(@focus)
        clear
      end
      #todo: process movement
      @list.each do |x|
        x.update ch
      end
      set_focus(@focus)
    end

    def draw
      @list.each { |x| x.draw }
    end

    def set_focus(widget)
      @focus = @list[@list.index(widget)]
      move @focus.curs.y, @focus.curs.x
    end

    def center
      @focus.move(80, 20)
    end
  end
end
