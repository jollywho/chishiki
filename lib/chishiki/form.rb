module Chishiki
  class Form
    attr_accessor :list
    def initialize
      @list = []
    end

    def add(widget)
      if @focus.nil?
        @focus = widget
      end
      @list.push widget
    end

    def remove(widget)
      @list.pop widget
    end

    def update(ch)
      #todo: process movement
      @list.each do |x|
        x.update ch
      end
    end

    def draw
      @px = getyx stdscr
      @focus.draw
      refocus
    end

    def set_focus(widget)
      @focus = @list[@list.index(widget)]
      refocus
    end
      
    def refocus
      move @focus.curs.y, @focus.curs.x
    end
  end
end
