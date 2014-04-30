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
      set_focus
    end

    def set_focus
      #@focus = @list[@list.index(widget)]
    end

    def center
      @focus.move(80, 20)
    end
  end
end
