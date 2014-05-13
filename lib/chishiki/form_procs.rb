module Chishiki
  class Form
    def load_procs
      @mode.store :nav,  107, Proc.new { ch_focus @@focus.up }
      @mode.store :nav,  106, Proc.new { ch_focus @@focus.down }
      @mode.store :nav,  104, Proc.new { ch_focus @@focus.left }
      @mode.store :nav,  108, Proc.new { ch_focus @@focus.right }
      @mode.store :nav,  111, Proc.new { ch_focus @@focus.add_leaf; do_modes }
      @mode.store :nav,  100, Proc.new { ch_focus @@focus.delete_branch }
      @mode.store :nav,  110, Proc.new { ch_focus @@focus.add_branch; do_modes }
      @mode.store :nav,  97,  Proc.new { do_modes }
      @mode.store :edit, 27,  Proc.new { do_modes }
    end
  end
end
