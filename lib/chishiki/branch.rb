module Chishiki
  class Branch
    attr_accessor :pos, :parent, :children
    def initialize(parent, pos)
      @parent = parent
      @pos = pos
      @pos.y += @pos.h
      @children = []
      @txt = Text.new(@pos.dup)
      @node = Label.new(@pos.dup.sh(-NODEWIDTH - PIPEWIDTH, 0), TYPES[type])
      @pipe = Label.new(@pos.dup.sh(-PIPEWIDTH, 0), PIPE * PIPEWIDTH)
    end

    def type
      if @parent == nil
        :head
      elsif @children.size > 0
        :body
      else
        :tail
      end
    end

    def index
      @parent.nil? ? 0 : @parent.children.index(self)
    end

    def new_branch(expand)
      if expand
        @parent.new_branch false
      else
        br = Branch.new(self, @pos.dup.sh(2,1))
        @children.push br
        br
      end
    end

    def next_child(dir)
      if @parent.nil?
        self
      elsif @parent.children.at(index + dir).nil?
        self
      else
        @parent.children[index + dir]
      end
    end

    def up
      index == 0 ? left : next_child(-1)
    end

    def down
      if @children.size < 1
        self
      elsif index + 1 >= @children.size
        @children[0]
      else
        next_child(1)
      end
    end

    def left
      @parent.nil? ? self : @parent
    end

    def right
      down
    end

    def handle_key(ch)
      @txt.handle_key ch
    end

    def focus
      move @txt.curs.y + Form.os.y, @txt.curs.x + Form.os.x
    end

    def seek(seeker, branch, &c)
      yield self
      if branch != nil
        if seeker != branch
          branch.seek branch, branch.parent, &c
          if !branch.children.nil?
            branch.children.each { |x| branch.seek seeker, x, &c }
          end
        end
      end
    end 

    def render
      @node.draw
      @pipe.draw
      @txt.draw
    end

    def draw
      seek(self, @parent) { |x| x.render }
    end

  end
end
