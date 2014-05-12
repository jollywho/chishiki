module Chishiki
  class Form
    def initialize
      @@focus = nil
      @list = []
      win = getmaxyx stdscr
      $window = Pos.new(0,0,win[1],win[0])
      @@clear = Label.new(Pos.new(
        0,0,$window.w, $window.h),
        " " * $window.w * $window.h, 0)
      $log.debug @clear
      $center = Pos.new(
        $window.w/2.0 - TEXTWIDTH/4.0,
        $window.h/2.0 - TEXTHEIGHT/2.0)
      @@offset = Pos.new
      @@nlo_dir = 0
      @@nlo = 0
      @@focus = Branch.new(nil, Pos.new)
      Form.shift
      ch_mode
    end

    def ch_mode
      @mode = false unless !@mode.nil?
      @mode = !@mode
    end

    def update(ch)
      Form.reset_nlo
      if ch == 6 # ^f
        ch_focus @@focus.delete
      elsif ch == 49 # !
        ch_focus @@focus.up
      elsif ch == 50 # 1
        ch_focus @@focus.down
      elsif ch == 51 # 2
        ch_focus @@focus.left
      elsif ch == 52 # 3
        ch_focus @@focus.right
      elsif ch == 2 # ^b
        ch_focus @@focus.add_leaf
      elsif ch == 14 # ^n
        ch_focus @@focus.add_branch
      elsif ch == 48 # 0
        ch_focus @@focus
      else
        @@focus.handle_key ch
      end
    end

    def draw
      @@focus.draw
      @@focus.focus
    end

    def ch_focus(branch)
      @@focus = branch
      Form.shift
    end

    def self.focus
      @@focus
    end

    def self.shift
      @@clear.draw_abs
      @@offset.x = $center.x - @@focus.pos.x + @@focus.pos.w/2
      @@offset.y = $center.y - @@focus.pos.y + @@focus.pos.h/2
    end

    def self.bump_nlo(y, dir)
      @@nlo = y
      @@nlo_dir = dir
      if @@focus != nil
        shift
      end
    end

    def self.reset_nlo
      $log.debug "NLO #{@@nlo_dir}"
      @@focus.handle_growth
      @@nlo_dir = 0
      @@nlo = 0
    end

    def self.nlo_dir
      @@nlo_dir
    end

    def self.nlo
      @@nlo
    end

    def self.os
      @@offset
    end

  end
end
