# stem holds:
# 1 text,
# 1 label,
# 1 pipe < label

module Chishiki
  class Stem
    attr_accessor :pos
    def initialize(pos)
      @pos = pos.dup
    end

  end
end
