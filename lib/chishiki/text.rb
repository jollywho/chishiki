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
      @index += 1
      @list.push Line.new(@pos.dup, @index)
      #todo: height has changed, tell form to reshift
    end

    def size
      @list.size
    end

    def del_line
      if @list.size > 1
        @list.delete_at(@index)
        @index -= 1
        @list[@index].del
      end
    end

    def shift(pos) # rel
      $log.debug "move text"
      $log.debug "#{pos.x},#{pos.y}"
      @pos.x = pos.x
      @pos.y = pos.y
      @list.each { |x| z.move(pos) }
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
      @list.each { |x| x.draw }
    end
  end
end
