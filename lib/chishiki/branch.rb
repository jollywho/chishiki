module Chishiki
  class NilBranch
    attr_accessor :parent
    def children
      []
    end
    def cib
      1
    end
    def name
      "branch_0"
    end
  end

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
      @node = Label.new(@pos.dup.sh(-NODEWIDTH - PIPEWIDTH, 0), TYPES[type])
      @pipe = Label.new(@pos.dup.sh(-PIPEWIDTH, 0), PIPE * PIPEWIDTH)
      @height = 0
    end

    def parent
      $log.debug "NilBranch? #{@parent.nil?}"
      @parent.nil? ? NilBranch.new : @parent
    end

    def leaf?
      @children.empty?
    end

    def type
      leaf? ? :tail : :body
    end

    def [](index)
      @children[index]
    end

    def add_child
      @cib += 1
      px = @pos.sh(2, @cib * 1)
      br = Branch.new(self, px.dup)
      $log.debug "Added #{br.inspect}"
      @children.insert 0, br
      br
    end

    def next_child(dir)
      $log.debug "--3"
      parent_t.children[index + dir]
    end

    def last
      @children.last.nil? ? self : @children.last
    end

    def up
      @parent.nil? ? self :
        parent.children.index(self) == 0 ? left :
        parent.children[parent.children.index(self) - 1]
    end

    def down
    end

    def left
      @parent.nil? ? self : parent
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
