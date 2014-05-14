module Chishiki
  class Form
    def initialize
      Form.focus = nil
      @list = []
      Form.init
      Form.os = Pos.new
      Form.nlo_dir = 0
      Form.nlo = 0
      Form.focus = Branch.new(nil, Pos.new)
      @mode = ModeHandler.instance
      load_procs
      set_marker
      Form.shift
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
