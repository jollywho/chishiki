require 'yaml'
module Chishiki
  module Seed
    class << self
      def cultivate()
        begin
          found = File.file? ARGV[0]
          @file = File.open(ARGV[0], 'a+')
          if found
            replant
          else
            false
          end
        rescue
          endwin
          puts "Error loading file: #{ARGV[0]}" \
            "#{ "<file required>" if ARGV[0].nil? }"
          abort
        end
      end

      def plant(branch, focus)
        data = { :branch => branch, :focus => focus }
        @file.close
        @file = File.open(ARGV[0], 'w')
        @file.puts YAML.dump(data)
        @planted = true
      end

      def bury
        @file.close
        unless @planted
          File.delete(ARGV[0])
        end
      end

      def replant
        data = YAML.load(@file.read)
        branch = data[:branch]
        focus = data[:focus]
        Branch.stem = branch
        Form.focus = focus
        @planted = true
      end
    end
  end
end
