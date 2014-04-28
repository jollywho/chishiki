module Chishiki
  class Widget
    attr_accessor :pos
    def initialize args
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def draw
    end
  end
end
