module Chishiki
  class NilBranch
    def children
      []
    end
    def parent
    end
  end

  class Branch
    attr_accessor :pos, :children, :parent
    def initialize(parent, pos)
      $log.debug "new branch"
      @parent = parent
      @pos = pos
      @pos.y += @pos.h
      @children = []
      @txt = Text.new(@pos.dup)
      @node = Label.new(@pos.dup.sh(-NODEWIDTH - PIPEWIDTH, 0), TYPES[type])
      @pipe = Label.new(@pos.dup.sh(-PIPEWIDTH, 0), PIPE * PIPEWIDTH)
      @height = 0
    end

    def parent_t
      @parent.nil? ? NilBranch.new : @parent
    end

    def type
      if @parent == nil
        :head
      elsif @parent.children.size > 0
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
        br = Branch.new(self, @pos.dup.sh(2,@height))
        @children.push br
        br
      end
    end

    def next_child(dir)
      $log.debug "--3"
      parent_t.children[index + dir]
    end

    def up
      index == 0 ? left : next_child(-1)
    end

    def down
      c = next_child(1)
      if c == nil 
        $log.debug "--4"
        if @children.size < 1
          self
        else
          @children[0]
        end
      else
        c
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

    def seek(seeker, branch, climb, &c)
      yield self
      if branch != nil

        if seeker != branch
          if climb
            branch.seek branch, branch.parent, true, &c
          else
           !branch.children.nil?
            $log.debug "child"
            branch.children.each { |x| x.seek branch, x, false, &c }
          end
        end
      end
    end 

    def render
      if @first
        @first = true
      else
        dir = Form.nlo_dir
        if @height > Form.nlo
          @pos.y += dir
        else
          @height += dir
        end
        @node.draw
        @pipe.draw
        @txt.draw
    end
    end

    def draw
      $log.debug "draw"
      seek(self, @parent, true) { |x| x.render }
    end

  end
end
