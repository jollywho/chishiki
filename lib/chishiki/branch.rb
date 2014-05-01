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

    def new_branch(expand)
      if expand
        @parent.new_branch false
      else
        br = Branch.new(self, @pos.dup.sh(1,1))
        @children.push br
        br
      end
    end

    def handle_key(ch)
      @txt.handle_key ch
    end

    def focus
      move @txt.curs.y, @txt.curs.x
    end

    def seek(seeker, branch, &c)
      $log.debug "Seek: #{seeker.object_id}"
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
      $log.debug "Draw #{self.object_id}"
      seek(self, @parent) { |x| x.render }
    end

  end
end
