module Chishiki
  class Pos
    attr_accessor :x, :y, :w, :h
    def initialize(x=0,y=0,w=0,h=0)
      @x = x
      @y = y
      @w = w
      @h = h
    end

    def to_s
      "[#{x}, #{y}]"
    end
  end
end
