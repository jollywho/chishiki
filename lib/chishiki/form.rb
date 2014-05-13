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
      @mode = ModeHandler.instance
      @mode.store :nav,  49, Proc.new { ch_focus @@focus.up }
      @mode.store :nav,  50, Proc.new { ch_focus @@focus.down }
      @mode.store :nav,  51, Proc.new { ch_focus @@focus.left }
      @mode.store :nav,  52, Proc.new { ch_focus @@focus.right }
      @mode.store :nav,  2,  Proc.new { ch_focus @@focus.add_leaf }
      @mode.store :nav,  6,  Proc.new { ch_focus @@focus.delete_branch }
      @mode.store :nav,  14, Proc.new { ch_focus @@focus.add_branch }
      @mode.store :nav,  65, Proc.new { @mode.swap_modes }
      @mode.store :edit, 27, Proc.new { @mode.swap_modes }
    end

    def update(ch)
      Form.reset_nlo
      ch = @mode.swallow ch
      @@focus.handle_key ch unless ch.nil?
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
