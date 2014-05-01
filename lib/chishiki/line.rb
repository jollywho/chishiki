module Chishiki
  class Line
    attr_accessor :curs, :pos, :line
    def initialize(pos, line)
      $log.debug "new line"
      @pos = pos
      @line = line
      @msg = ""
      @pos.y += @line
      @curs = Pos.new(@pos.x, @pos.y, 1, 1)
      $log.debug @pos
    end

    def del
      if @curs.x <= @pos.x
        false
      else
        @msg.slice! @msg.size - 1 
        @curs.x -= 1
        mvwdelch stdscr, @curs.y + Form.os.y, @curs.x + Form.os.x
        $log.debug @curs
        $log.debug @msg
        true
      end
    end

    def add_ch(ch)
      $log.debug @pos
      if @curs.x + 1 >= @pos.x + @pos.w
        false
      else
        $log.debug "line add ch"
        @msg += ch.chr
        @curs.x = @pos.x + @msg.size
        true
      end
    end

    def shift(pos)
      @curs.x += pos.x
      @curs.y += pos.y
      @pos.x = x
      @pos.y = y + @line
    end

    def draw
        mvwaddstr stdscr, @pos.y + Form.os.y, @pos.x + Form.os.x, @msg
    end
  end
end
