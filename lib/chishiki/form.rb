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
      if ch == 6
        remove(@focus)
        clear
      end
      #todo: process movement
      @list.each do |x|
        x.update ch
      end
    end

    def draw
      @list.each { |x| x.draw }
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
