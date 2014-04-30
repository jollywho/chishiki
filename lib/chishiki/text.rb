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
      @index = -1
      new_line
    end

    def new_line
      @index += 1
      @list.push Line.new(
        :pos => @pos.dup, :line => @index)
    end

    def del_line
      if @list.size > 1
        @list.delete_at(@index)
        @index -= 1
        @list[@index].del
      end
    end

    def move(x, y)
      $log.debug "move text"
      $log.debug "#{x},#{y}"
      @pos.x = x
      @pos.y = y
      @list.each { |z| z.move(x, y) }
    end

    def curs
      @list[@index].curs
    end

    def update(ch)
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
      @list[@index].draw
      #@list.each { |x| x.draw }
    end
  end
end
