module Chishiki
  class Form
    def initialize
      @list = []
      win = getmaxyx stdscr
      @window = Pos.new(0,0,win[1],win[0])
      @center = Pos.new(
        @window.w/2.0 - TEXTWIDTH/2.0,
        @window.h/2.0 - TEXTHEIGHT/2.0)
      @@offset = Pos.new
      @focus = Branch.new(nil, Pos.new)
      shift
      ch_mode
    end

    def ch_mode
      @mode = false unless !@mode.nil?
      @mode = !@mode
    end

    def update(ch)
      if ch == 6 # ^f
      elsif ch == 33 # !
        ch_mode
        @focus = @focus.up
      elsif ch == 64 # @
        @focus = @focus.down
      elsif ch == 35 # #
        @focus = @focus.left
      elsif ch == 36 # $
        @focus = @focus.right
      elsif ch == 2 # ^b
        @focus = @focus.new_branch true
      elsif ch == 14 # ^n
        @focus = @focus.new_branch false
        shift
      else
        @focus.handle_key ch
      end
      $log.debug @focus.object_id
    end

    def draw
      @focus.draw
      @focus.focus
    end

    def shift
      clear
      @@offset.x = @center.x - @focus.pos.x
      @@offset.y = @center.y - @focus.pos.y
    end

    def self.os
      @@offset
    end

  end
end
