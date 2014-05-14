module Chishiki
  class Form
    def load_procs
      @mode.store :nav,  107, Proc.new { ch_focus Form.focus.up }
      @mode.store :nav,  106, Proc.new { ch_focus Form.focus.down }
      @mode.store :nav,  104, Proc.new { ch_focus Form.focus.left }
      @mode.store :nav,  108, Proc.new { ch_focus Form.focus.right }
      @mode.store :nav,  111, Proc.new { ch_focus Form.focus.add_leaf; do_modes }
      @mode.store :nav,  100, Proc.new { ch_focus Form.focus.delete_branch }
      @mode.store :nav,  110, Proc.new { ch_focus Form.focus.add_branch; do_modes }
      @mode.store :nav,  97,  Proc.new { do_modes }
      @mode.store :edit, 27,  Proc.new { do_modes }
    end

    class << self
      attr_accessor :nlo, :nlo_dir, :os, :focus, :clear
      def shift
        Form.clear.draw_abs
        Form.os.x = $center.x - Form.focus.pos.x + Form.focus.pos.w/2
        Form.os.y = $center.y - Form.focus.pos.y + Form.focus.pos.h/2
      end

      def bump_nlo(y, dir)
        Form.nlo = y
        Form.nlo_dir = dir
        if Form.focus != nil
          shift
        end
      end

      def reset_nlo
        $log.debug "NLO #{Form.nlo_dir}"
        Form.focus.handle_growth
        Form.nlo_dir = 0
        Form.nlo = 0
      end
    end
  end
end
