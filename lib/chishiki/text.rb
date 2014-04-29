module Chishiki
  class Line
    attr_accessor :curs, :pos, :msg
    def initialize args
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
    end
      @msg = ""
      @ch = ""
      @curs = @pos.dup
    end

    def del
      if @curs.x <= @pos.x
        false
      else
        @msg[@curs.x - @pos.x - 1] = ""
        $log.debug @msg
        @curs.x -= 1
        mvwdelch stdscr, @curs.y, @curs.x
        true
      end
    end

    def add_ch(ch)
      if @curs.x + 1 >= @pos.w
        false
      else
        @render = true
        @ch = ch.chr
        @msg += ch.chr
        @curs.x += 1
        true
      end
    end

    def draw
      if @render
        mvwaddch stdscr, @curs.y, @curs.x - 1 , @ch.ord
      end
        @render = false
    end
  end
end
