module Chishiki
  class Form
    def load_procs
      @mode.store :nav,  49, Proc.new { ch_focus @@focus.up }
      @mode.store :nav,  50, Proc.new { ch_focus @@focus.down }
      @mode.store :nav,  51, Proc.new { ch_focus @@focus.left }
      @mode.store :nav,  52, Proc.new { ch_focus @@focus.right }
      @mode.store :nav,  2,  Proc.new { ch_focus @@focus.add_leaf }
      @mode.store :nav,  6,  Proc.new { ch_focus @@focus.delete_branch }
      @mode.store :nav,  14, Proc.new { ch_focus @@focus.add_branch }
      @mode.store :nav,  65, Proc.new { @mode.swap_modes; set_marker }
      @mode.store :edit, 27, Proc.new { @mode.swap_modes; set_marker }
    end
  end
end
