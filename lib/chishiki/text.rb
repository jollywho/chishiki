module Chishiki
  class Text
    attr_accessor :pos
    def initialize(pos)
      @pos = pos
      @list = []
      @pos.w = 40
      @pos.h = 1
      @index = -1
      $log.debug "new Text"
      $log.debug @pos
      new_line
    end

    def new_line
      @grow = true
      @index += 1
      @list.push Line.new(@pos.dup, @index)
      Form.bump_nlo @list[@index].pos.y, 1
    end

    def grow!
      was = @grow
      @grow = false
      was
    end

    def size
      @list.size
    end

    def del_line
      if @list.size > 1
        @grow = false
        Form.bump_nlo @list[@index].pos.y, -1
        @list.delete_at(@index)
        @index -= 1
        @list[@index].del
      end
    end

    def curs
      @list[@index].curs
    end

    def handle_key(ch)
      $log.debug "text update"
      if ch == 127 # delete
        del_line unless @list[@index].del
      elsif ch == 10 # newline
        new_line unless @list.size < @index
      else # regular processing
        new_line unless @list[@index].add_ch ch
      end
    end

    def draw
      if @pos.y > Form.nlo
        @pos.y += Form.nlo_dir
      end
      @list.each { |x| x.draw }
    end
  end
end
