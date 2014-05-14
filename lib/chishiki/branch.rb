module Chishiki
  class Branch
    attr_accessor :pos, :children, :parent, :cib, :name, :pipe
    @@seek
    def initialize(node, pos)
      $log.debug "=============new branch============"
      @@seek = self unless !node.nil?
      @parent = node
      @name = parent.name[0..-2] + ((parent.name[-1].to_i) + 1).to_s
      @pos = pos
      @children = []
      @txt = Text.new(@pos.dup)
      @node = Label.new(@pos.dup.sh(NODE_START, 0), TYPES[:head], YELLOW)
      @marker = Label.new(@pos.dup.sh(MARKER_WIDTH, 0), MARKER_F_N, GREEN)
      @wpipe = Label.new(@pos.dup.sh(PIPE_WIDTH, 0), CHAR_WPIPE * PIPE_SIZE, GREEN)
      @cib = 0
      @height = 0
      @created = true
      @pipe = Pipe.new(@pos.dup.sh(NODE_START, -1),
                       self.parent, pipe_tar)
      @widgets = []
      @widgets << @pipe << @marker << @node << @wpipe << @txt
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
      @cib += x
      @parent.inc_cib x unless @parent.nil?
    end

    def add_branch
      inc_cib 1
      px = @pos.dup.sh(2, @cib)
      br = Branch.new(self, px)
      @children.push br
      @height = 0
      br
    end

    def add_leaf
      @parent.nil? ? self : parent.add_branch
    end

    def delete_branch
      if @parent.nil?
        self
      else
        u = up
        d = down
        ix= parent.children.index(self)
        if ix != parent.children.size && ix != 0
          d.swap_tar(u, @cib + u.cib + 1)
        else
          d.swap_tar(u, @cib + 2)
        end
        @parent.children.delete(self)
        Form.bump_nlo @pos.y - 1, -@cib - 1
        inc_cib -@cib - 1
        u
      end
    end

    def swap_tar(tar, cib)
      @pipe.swap_tar tar, cib
    end

    def pipe_tar
      if @parent.nil?
        self
      elsif parent.leaf
        parent
      else
        parent.children.last
      end
    end

    def up
      if @parent.nil?
        self
      elsif parent.children.index(self) == 0
        left
      else
        parent[parent.children.index(self) - 1]
      end
    end

    def down
      d = parent.children.index(self)
      d = parent[parent.children.index(self) + 1] unless d.nil?
      if !d.nil?
        d
      elsif !leaf
        right
      else
        self
      end
    end

    def left
      @parent.nil? ? self : parent
    end

    def right
      leaf ? self : @children[0]
    end

    def set_focus_color
      @pipe.set_color RED
      @node.set_color RED
      @wpipe.set_color RED
    end

    def unset_focus_color
      @pipe.set_color YELLOW
      @node.set_color YELLOW
      @wpipe.set_color YELLOW
    end

    def set_marker_edit
      parent.children.each { |x| x.set_focus_color }
      @wpipe.set_color CYAN
      @marker.set_msg MARKER_F_E
    end

    def set_marker_normal
      parent.children.each { |x| x.set_focus_color }
      @wpipe.set_color CYAN
      @marker.set_msg MARKER_F_N
    end

    def unset_marker
      @wpipe.set_color YELLOW
      parent.children.each { |x| x.unset_focus_color }
      @marker.set_msg MARKER_N_N
    end

    def handle_key(ch)
      @txt.handle_key ch
    end

    def handle_growth
      inc_cib 1 unless !@txt.grow!
      inc_cib -1 unless !@txt.shrink!
    end

    def focus
      move @txt.curs.y + Form.os.y,
        @txt.curs.x + Form.os.x
    end

    def seek(&c)
      yield self
      @children.each do |x|
        x.seek &c
      end
    end

    def render
      if @created
        @created = false
      elsif @pos.y >= Form.nlo && Form.nlo_dir != 0
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
