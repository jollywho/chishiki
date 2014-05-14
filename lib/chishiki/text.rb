module Chishiki
  class Text
    TEXT_WIDTH = 40
    TEXT_HEIGHT = 1

    attr_accessor :pos

    def initialize(pos)
      @pos = pos
      @list = []
      @pos.w = TEXT_WIDTH
      @pos.h = 1
      @index = -1
      new_line(2)
    end

    def new_line(y)
      carry = @list[@index].carry! unless @index < 0
      @grow = true
      @index += 1
      @list.push Line.new(@pos.dup, @index)
      Form.bump_nlo @list[@index].pos.y, y
      @list[@index].receive carry unless carry.nil?
    end

    def grow!
      was = @grow
      @grow = false
      was
    end

    def shrink!
      was = @shrink
      @shrink = false
      was
    end

    def size
      @list.size
    end

    def del_line()
      if @list.size > 1
        @shrink = true
        Form.bump_nlo @list[@index].pos.y, -1
        @list.delete_at(@index)
        @index -= 1
        @list[@index].del
      end
    end

    def del_all
      Form.bump_nlo @pos.y - 1, -@list.size - 1
    end

    def insert_nl
      @list[@index].newline
      new_line(1)
    end

    def curs
      @list[@index].curs
    end

    def handle_key(ch)
      $log.debug "text update"
      if ch == 127 # delete
        del_line unless @list[@index].del
      elsif ch == 10 # newline
        insert_nl unless @list.size < @index
      else # regular processing
        new_line(1) unless @list[@index].add_ch ch
      end
    end

    def move(y)
      @pos.y += y
      @list.each { |x| x.move(y) }
    end

    def draw
      @list.each { |x| x.draw }
    end
  end
end
