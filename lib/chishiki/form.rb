module Chishiki
  class Form
    def initialize
      @@focus = nil
      @list = []
      init
      @@offset = Pos.new
      @@nlo_dir = 0
      @@nlo = 0
      @@focus = Branch.new(nil, Pos.new)
      @mode = ModeHandler.instance
      load_procs
      set_marker
      Form.shift
    end

    def init
      @@clear = Label.new(Pos.new(
        0,0,$window.w, $window.h),
        " " * $window.w * $window.h, 0)
      $center = Pos.new(
        $window.w/2.0 - TEXTWIDTH/4.0,
        $window.h/2.0 - TEXTHEIGHT/2.0)
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

    def do_modes
      @mode.swap_modes
      set_marker
    end

    def set_marker
      if @mode.get_mode == :nav
        @@focus.set_marker_normal
      else
        @@focus.set_marker_edit
      end
    end

    def ch_focus(branch)
      @@focus.unset_marker
      @@focus = branch
      set_marker
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
