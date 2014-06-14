module Chishiki
  class Form
    def load_procs
      @mode.store :nav,  107, proc { ch_focus Form.focus.up }
      @mode.store :nav,  106, proc { ch_focus Form.focus.down }
      @mode.store :nav,  104, proc { ch_focus Form.focus.left }
      @mode.store :nav,  108, proc { ch_focus Form.focus.right }
      @mode.store :nav,  79, proc { ch_focus Form.focus.add_leaf
                                     do_modes }
      @mode.store :nav,  68, proc { ch_focus Form.focus.delete_branch }
      @mode.store :nav,  111, proc { ch_focus Form.focus.add_branch
                                     do_modes }
      @mode.store :nav,  97,  proc { do_modes }
      @mode.store :edit, 27,  proc { do_modes }
      @mode.store :edit, 21,  proc { do_clear }
      @mode.store :nav,  83,  proc { save }
    end

    class << self
      attr_accessor :nlo, :nlo_dir, :os, :focus, :clear, :center

    def init
      @clear = Label.new(Pos.new(
        0, 0, $window.w, $window.h),
        " " * $window.w * $window.h, 0)
      @center = Pos.new(
        $window.w / 2.0 - Text::TEXT_WIDTH / 4.0,
        $window.h / 2.0 - Text::TEXT_HEIGHT / 2.0)
    end

      def shift
        @clear.draw_abs
        os.x = @center.x - @focus.pos.x + @focus.pos.w / 2
        os.y = @center.y - @focus.pos.y + @focus.pos.h / 2
      end

      def bump_nlo(y, dir)
        @nlo = y
        @nlo_dir = dir
        if @focus != nil
          shift
        end
      end

      def reset_nlo
        @focus.handle_growth
        @nlo_dir = 0
        @nlo = 0
      end
    end
  end
end
