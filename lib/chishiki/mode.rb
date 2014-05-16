require 'singleton'
module Chishiki
  class ModeHandler
    include Singleton
    def initialize
      @modes = { :nav => Mode.new, :edit => Mode.new }
      @cur = :nav
    end

    def mode
      @modes[@cur]
    end

    def get_mode
      @cur
    end

    def swap_modes
      @cur =
        if @cur == :nav
          :edit
        else
          :nav
        end
    end

    def swallow(ch)
      if !mode.command(ch) && get_mode == :edit
        ch
      else
        nil
      end
    end

    def store(mode, ch, p)
      @modes[mode].store ch, p
    end
  end
end

class Mode
  def initialize
    @procs = {}
  end
  def store(ch, p)
    @procs[ch] = p
  end
  def to_s
  end
  def command(ch)
    p = @procs[ch]
    p.call unless p.nil?
    p.nil? ? false : true
  end
end
