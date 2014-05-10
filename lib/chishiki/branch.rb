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
      @pos = pos
      @children = []
      @txt = Text.new(@pos.dup)
      @node = Label.new(@pos.dup.sh(NODESTART, 0), TYPES[:head], 4)
      @wpipe = Label.new(@pos.dup.sh(PIPEWIDTH, 0), "-" * -PIPEWIDTH, 2)
      @cib = 0
      @height = 0
      @created = true
      @pipe = Pipe.new(@pos.dup.sh(NODESTART, -1),
                       self.parent.dup, pipe_tar.dup)
      @widgets = []
      @widgets << @pipe << @node << @wpipe << @txt
    end

    def parent
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

    def inc_cib(x)
      $log.debug "INC CIB #{x}"
      @cib += x
      @parent.inc_cib x unless @parent.nil?
    end

    def add_branch
      inc_cib 1
      px = @pos.dup.sh(2, @cib)
      br = Branch.new(self, px)
      $log.debug "Added #{br.inspect}"
      @children.push br
      @height = 0
      br
    end

    def add_leaf
      @parent.nil? ? self : parent.add_branch
    end

    def pipe_tar
      @parent.nil? ? self :
        parent.leaf ? parent :
        parent.children.last
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

    def handle_growth
      inc_cib 1 unless !@txt.grow!
      inc_cib -1 unless !@txt.shrink!
    end

    def focus
      move @txt.curs.y + Form.os.y, @txt.curs.x + Form.os.x
    end

    def seek(&c)
      yield self
      @children.each do |x|
        x.seek &c
      end
    end

    def render
      if @created
        $log.debug "Didn't created #{@pos.y}"
        @created = false
      elsif @pos.y >= Form.nlo
        $log.debug "DID Pos #{@pos.y} Form #{Form.nlo}"
        @pos.y += Form.nlo_dir
        @widgets.each { |x| x.move Form.nlo_dir }
      end
      @widgets.each { |x| x.draw }
    end

    def draw
      @@seek.seek { |x| x.render }
    end

    def inspect
      "#{name} : #{@pos}"
    end
  end
end
