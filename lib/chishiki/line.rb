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
        @msg.slice! @msg.size - 1 
        @curs.x -= 1
        mvwdelch stdscr, @curs.y, @curs.x
        $log.debug @msg
        true
      end
    end

    def add_ch(ch)
      if @curs.x + 1 >= @pos.w
        false
      else
        @render = true
        @msg += ch.chr
        @curs.x = @msg.length + @pos.x
        true
      end
    end

    def draw
      if @render
        mvwaddstr stdscr, @pos.y, @pos.x, @msg
      end
        @render = false
    end
  end
end
