module Chishiki
  class Line
    attr_accessor :curs, :pos, :msg, :line
    def initialize args
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
    end
      @msg = ""
      @pos.y += @line
      @curs = Pos.new(@pos.x, @pos.y, 1, 1)
    end

    def del
      if @curs.x <= @pos.x
        false
      else
        @msg.slice! @msg.size - 1 
        @curs.x -= 1
        mvwdelch stdscr, @curs.y, @curs.x
        $log.debug @curs
        $log.debug @msg
        true
      end
    end

    def add_ch(ch)
      if @curs.x + 1 >= @pos.x + @pos.w
        false
      else
        $log.debug "line add ch"
        @msg += ch.chr
        @curs.x = @pos.x + @msg.size
        true
      end
    end

    def move(x, y)
      @curs.x = x - @pos.x
      @curs.y = y - @pos.y
      @pos.x = x
      @pos.y = y + @line
    end

    def remove
      mvwdelch stdscr, @curs.y, @curs.x
    end

    def draw
      $log.debug "line draw"
        mvwaddstr stdscr, @pos.y, @pos.x, @msg
    end
  end
end
