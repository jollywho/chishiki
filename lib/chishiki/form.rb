module Chishiki
  class Form
    def initialize
      Form.focus = nil
      Form.init
      Form.os = Pos.new
      Form.nlo_dir = 0
      Form.nlo = 0
      Form.focus = Branch.new(nil, Pos.new)
      @mode = ModeHandler.instance
      load_procs
      set_marker
    end

    def update(ch)
      Form.reset_nlo
      ch = @mode.swallow ch
      Form.focus.handle_key ch unless ch.nil?
    end

    def save
      Seed.plant Branch.stem, Form.focus
      Form.focus.show_status ARGV[0]
    end

    def load_file
      s = Seed.cultivate
      if !s
        Branch.stem = Form.focus
        ch_focus Branch.stem
      else
        ch_focus Form.focus
      end
    end

    def draw
      Form.focus.update
      Form.focus.draw
      Form.focus.focus
    end

    def do_clear
      Form.focus.clear
      Form.shift
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
