module Chishiki
  class Form
    attr_accessor :focus, :list
    def initialize
      @list = []
    end

    def add(widget)
      @list.push widget
    end

    def remove(widget)
      @list.pop widget
    end

    def draw
      @list.each do |x|
        x.draw
      end
    end
  end
end
