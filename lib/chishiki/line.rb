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
          $log.debug "line add #{ch}"
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
      attr_set A_NORMAL, 3, nil
      Renderer.draw(@pos.x, @pos.y, @msg)
    end
  end
end
