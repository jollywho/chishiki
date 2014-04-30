# branch holds 1+ stems

module Chishiki
  class Branch
    attr_accessor :pos
    def initialize(parent, pos)
      @parent = parent.nil? ? self : parent
      @pos = pos
      @children = []
      @txt = Text.new(@pos.dup)
      @node = Label.new(@pos.dup.sh(-23, 0), TYPES[:tail])
      @pipe = Label.new(@pos.dup.sh(-20, 0), TYPES[:pipe]*20)
    end

    def new_branch(expand)
      if expand
        @parent.new_branch false
      else
        @children.push Branch.new(@pos.dup)
      end
    end

    def handle_key(ch)
      @txt.handle_key ch
    end

    def draw
      @node.draw
      @pipe.draw
      @txt.draw
    end

  end
end
