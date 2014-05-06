module Chishiki
  class Branch
    attr_accessor :pos, :children, :parent, :cib, :name
    @@seek
    def initialize(node, pos)
      $log.debug "=============new branch============"
      @@seek = self unless !node.nil?
      @parent = node
      $log.debug "\tits parent is #{parent.name}"
      @name = parent.name[0..-2] + ((parent.name[-1].to_i) + 1).to_s
      @cib = 1
      @pos = pos
      @children = []
      @txt = Text.new(@pos.dup)
      @node = Label.new(@pos.dup.sh(-NODEWIDTH - PIPEWIDTH, 0), TYPES[:head])
      @pipe = Label.new(@pos.dup.sh(-PIPEWIDTH, 0), PIPE * PIPEWIDTH)
      @height = 0
    end

    def parent
      $log.debug "NilBranch? #{@parent.nil?}"
      @parent.nil? ? NilBranch.new : @parent
    end

    def leaf
      @children.empty?
    end

    def type
      leaf ? :tail : :body
    end

    def [](index)
      @children[index]
    end

    def add_branch
      @cib += 1
      px = @pos.sh(@cib > 2 ? 0 : 2, 1 + @height)
      br = Branch.new(self, px.dup)
      $log.debug "Added #{br.inspect}"
      @children.push br
      @height = 0
      br
    end

    def add_leaf
      parent.add_branch
    end

    def up
      @parent.nil? ? self :
        parent.children.index(self) == 0 ? left :
          parent[parent.children.index(self) - 1]
    end

    def down
      $log.debug "DOWN"
      d = parent.children.index(self)
      $log.debug d
      d = parent[parent.children.index(self) + 1] unless d.nil?
      $log.debug d
      !d.nil? ? d : !leaf ? right :  self
    end

    def left
      $log.debug "LEFT"
      @parent.nil? ? self : parent
    end

    def right
      $log.debug "RIGHT"
      leaf ? self : @children[0]
    end

    def handle_key(ch)
      @txt.handle_key ch
    end

    def focus
      move @txt.curs.y + Form.os.y, @txt.curs.x + Form.os.x
    end

    def seek(&c)
      yield self
      $log.debug "^Seek #{@name}^"
      @children.each do |x|
        x.seek &c
      end
    end

    def render
      if @height > Form.nlo
        @pos.y += Form.nlo_dir
      else
        @height += Form.nlo_dir
      end
      @node.draw
      @pipe.draw
      @txt.draw
    end

    def draw
      $log.debug "draw"
      @@seek.seek { |x| x.render }
    end

    def inspect
      "#{name} : #{@pos}"
    end
  end
end
