module Chishiki
  class Renderer
    class << self
      def draw(x,y,msg)
        right = (msg.size + x + Form.os.x) - $window.w
        left =  (x + Form.os.x)
        if right > 0
          mvwaddstr stdscr, y + Form.os.y, x + Form.os.x, msg[0..-right - 1]
        elsif left < 0
          mvwaddstr stdscr, y + Form.os.y, x + -left + Form.os.x, msg[-left..-1]
        else
          mvwaddstr stdscr, y + Form.os.y, x + Form.os.x, msg
        end
      end
    end
  end
end
