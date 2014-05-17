require 'yaml'
module Chishiki
  module Seed
    class << self
      def cultivate()
        found = File.file? ARGV[0]
        @file = File.open(ARGV[0], 'a+')
        if found
          replant
        else
          false
        end
      end

      def plant(branch, focus)
        data = { :branch => branch, :focus => focus }
        @file.close
        @file = File.open(ARGV[0], 'w')
        @file.puts YAML.dump(data)
        @file.close
      end

      def replant
        begin
          data = YAML.load(@file.read)
          branch = data[:branch]
          focus = data[:focus]
          Branch.stem = branch
          Form.focus = focus
        ensure
          endwin
          puts "Error loading file: #{ARGV[0]}"
        end
      end
    end
  end
end
