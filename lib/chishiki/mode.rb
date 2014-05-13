require 'singleton'
module Chishiki
  class ModeHandler
    include Singleton
    def initialize
      @modes = { :nav => Nav.new, :edit => Edit.new }
      @cur = :nav
    end

    def mode
      @modes[@cur]
    end

    def swap_modes
      @cur = @cur == :nav ? :edit : :nav
    end

    def swallow(ch)
      $log.debug "MODE #{mode}"
      mode.call(ch).nil? ? ch : nil
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
  def call(ch)
    p = @procs[ch]
    p.nil? ? nil : p.call
  end
end

class Nav < Mode
  def to_s
    "Nav"
  end
end

class Edit < Mode
  def to_s
    "Edit"
  end
end
