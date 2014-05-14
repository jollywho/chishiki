module Chishiki
  class Line
    attr_accessor :curs, :pos, :line
    def initialize(pos, line)
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
        mvwdelch(
          stdscr,
          @curs.y + Form.os.y,
          @curs.x + Form.os.x
        )
        true
      end
    end

    def add_ch(ch)
      if @curs.x + 1 >= @pos.x + @pos.w
        false
      else
          @msg += ch.chr.scan(/[[:print:]]/).join
          @curs.x = @pos.x + @msg.size
        true
      end
    end

    def move(y)
      @pos.y += y
      @curs.y += y
    end

    def draw
      attr_set A_NORMAL, WHITE, nil
      Screen.draw @pos.x, @pos.y, @msg
    end
  end
end
