module Chishiki
  class Branch
    attr_accessor :pos
    def initialize(parent, pos)
      @parent = parent.nil? ? self : parent
      @type = 
      @pos = pos
      @pos.y += @pos.h
      @children = []
      @txt = Text.new(@pos.dup)
      @node = Label.new(@pos.dup.sh(-NODEWIDTH - PIPEWIDTH, 0), TYPES[type])
      @pipe = Label.new(@pos.dup.sh(-PIPEWIDTH, 0), PIPE * PIPEWIDTH)
    end

    def type
      if @parent == self
        :head
      elsif @children.size > 0
        :body
      else
        :tail
      end
    end

    def new_branch(expand)
      if expand
        @parent.new_branch false
      else
        br = Branch.new(@parent, @pos.dup)
        @children.push br
        br
      end
    end

    def handle_key(ch)
      @txt.handle_key ch
    end

    def draw
      #recurively draw parent and child until bounds
      @node.draw
      @pipe.draw
      @txt.draw
    end

  end
end
