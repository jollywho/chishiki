require 'yaml'
module Chishiki
  module Seed
    class Transplant
      def initialize(branch)
        @branch = branch
        Dir.chdir(File.dirname(__FILE__))
        @file = "../tmp/test.yml"
      end

      def plant
        @seed = @branch.to_yaml
        output = File.new('test.yaml', 'w')
        output.puts YAML.dump(@branch)
        output.close
      end

      def replant
        output = File.new('test.yaml', 'r')
        @branch = YAML.load(output.read)
        output.close
        @branch
      end
    end
  end
end
