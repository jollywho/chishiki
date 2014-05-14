module Chishiki
  class Form
    def initialize
      Form.focus = nil
      @list = []
      init
      Form.os = Pos.new
      Form.nlo_dir = 0
      Form.nlo = 0
      Form.focus = Branch.new(nil, Pos.new)
      @mode = ModeHandler.instance
      load_procs
      set_marker
      Form.shift
    end

    def init
      Form.clear = Label.new(Pos.new(
        0 ,0, $window.w, $window.h),
        " " * $window.w * $window.h, 0)
      $center = Pos.new(
        $window.w / 2.0 - Text::TEXT_WIDTH / 4.0,
        $window.h / 2.0 - Text::TEXT_HEIGHT / 2.0)
    end

    def update(ch)
      Form.reset_nlo
      ch = @mode.swallow ch
      Form.focus.handle_key ch unless ch.nil?
    end

    def draw
      Form.focus.draw
      Form.focus.focus
    end

    def do_modes
      @mode.swap_modes
      set_marker
    end

    def set_marker
      if @mode.get_mode == :nav
        Form.focus.set_marker_normal
      else
        Form.focus.set_marker_edit
      end
    end

    def ch_focus(branch)
      Form.focus.unset_marker
      Form.focus = branch
      set_marker
      Form.shift
    end
  end
end
