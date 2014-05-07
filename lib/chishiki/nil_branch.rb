module Chishiki
  class NilBranch < Branch
    attr_accessor :parent
    def initialize
    end
    def children
      []
    end
    def cib
      1
    end
    def leaf
      true
    end
    def name
      "branch_0"
    end
  end
end
