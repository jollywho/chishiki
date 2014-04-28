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

    def draw
      @px = getyx stdscr
      @list.each do |x|
        x.draw
      end
      refocus
    end

    def set_focus(widget)
      @focus = @list[@list.index(widget)]
      refocus
    end
      
    def refocus
      move @focus.pos.y, @focus.pos.x
    end
  end
end
