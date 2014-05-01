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

    def seek(seeker, branch)
      $log.debug "Seek: #{seeker.object_id}"
      @txt.draw
      if branch != nil
        if seeker != branch
          branch.seek branch, branch.parent
          if !branch.children.nil?
            branch.children.each { |x| branch.seek seeker, x }
          end
        end
      end
    end 

    def draw
      $log.debug "Draw #{self.object_id}"
      seek self, @parent
      @node.draw
      @pipe.draw
      @txt.draw
    end

  end
end
