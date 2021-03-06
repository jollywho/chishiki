module Chishiki
  class Pos
    attr_accessor :x, :y, :w, :h
    def initialize(x=0,y=0,w=0,h=0)
      @x = x
      @y = y
      @w = w
      @h = h
      self
    end

    def sh(x,y)
      @x += x
      @y += y
      self
    end

    def to_s
      "[#{x}, #{y}]"
    end

    def inspect
      "[#{x}, #{y}]"
    end
  end
end
