class String
  def indices e
    start, result = -1, []
    result << start while start = (self.index e, start + 1)
    result
  end
end

module Chishiki
  class Line
    attr_accessor :curs, :pos, :line
    def initialize(pos, line)
      @pos = pos
      @line = line
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
        mvwdelch(
          stdscr,
          @curs.y + Form.os.y,
          @curs.x + Form.os.x
        )
        true
      end
    end

    def del_word
      n = @msg.indices(/\s/).last
      if n.nil?
        n = @msg.size
      else
        n = @msg.size - n
      end
      (0..n-1).each { |i| del }
      n == 0 ? false : true
    end

    def receive(str)
      @msg = str
      @curs.x = @pos.x + @msg.size
    end

    def carry!
      if @carry.nil?
        nil
      else
        old = @carry.dup
        @carry.clear
        old
      end
    end

    def curs_adjust
      @curs.x = @pos.x + @msg.size
    end

    def clear
      @msg = ""
      curs_adjust
    end

    def newline
      @msg += ' '
      curs_adjust
    end

    def add_ch(ch)
      @msg += ch.chr
      if @curs.x + ch.size >= @pos.x + @pos.w
        idx = @msg.rindex(' ')
        if !idx.nil?
          @carry = @msg[idx + 1..-1]
          @msg = @msg[0..idx]
        end
        curs_adjust
        false
      else
        curs_adjust
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
