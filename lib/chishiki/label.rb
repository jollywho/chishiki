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

    def draw
      $log.debug self
      mvwaddch stdscr, @pos.y, @pos.x, @msg_i
    end
  end
end
