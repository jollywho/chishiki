module Chishiki
  class Text
    attr_accessor :pos
    def initialize args
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
      @list = []
      @pos.w = 40
      @pos.h = 1
      @list.push Line.new(
        :pos => pos)
      @index = 0
    end

    def new_line
      @index += 1
      tmp = @list[@index-1].pos.dup
      tmp.y += 1
      @list.push Line.new(
        :pos => tmp)
    end

    def del_line
      if @list.size > 1
        @list.delete_at(@index)
        @index -= 1
        @list[@index].del
      end
      #if empty delete
      #else wrap cursor up line
    end

    def curs
      @list[@index].curs
    end

    def update(ch)
      $log.debug "update"
      if ch == 127 # delete
        del_line unless @list[@index].del
      elsif ch == 10 # newline
        new_line unless @list.size < @index
      else # regular processing
        new_line unless @list[@index].add_ch ch
      end
    end

    def draw
      @list[@index].draw
    end
  end
end
