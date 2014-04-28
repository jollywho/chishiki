require './chishiki/widget.rb'
module Chishiki
  class Label < Widget
    attr_accessor :msg, :pos, :msg_i
    def initialize args
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
      @msg = ""
      @msg_i = 96
    end

###test for Text##here be dragons##
  #test for widget bounds on
    #add & delete
    def del
      @pos.x -=1
      mvwdelch stdscr, @pos.y, @pos.x
    end

    def draw
      mvwaddch stdscr, @pos.y, @pos.x, @msg_i
      @pos.x += 1
    end
  end
end
