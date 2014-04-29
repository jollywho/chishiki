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
      @list.delete_at(@list.index(widget))
    end

    def update(ch)
      if ch == 4
        remove(@focus)
      end
      #todo: process movement
      @list.each do |x|
        x.update ch
      end
    end

    def draw
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
