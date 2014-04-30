# stem holds:
# 1 text,
# 1 label,
# 1 pipe < label

module Chishiki
  class Stem
    attr_accessor :pos
    def initialize args
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

  end
end
