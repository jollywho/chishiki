#!/usr/bin/env ruby
#
#
require 'ffi-ncurses'
include FFI::NCurses

module Chishiki

  home = File.expand_path('../lib/chishiki', File.dirname(__FILE__))
  Dir["#{home}/*.rb"].each {|file| require file}

  begin
    initscr
    raw
    start_color
    use_default_colors
    init_pair(RED,     Color::RED,     -1)
    init_pair(GREEN,   Color::GREEN,   -1)
    init_pair(WHITE,   Color::WHITE,   -1)
    init_pair(MAGENTA, Color::MAGENTA, -1)
    init_pair(BLUE,    Color::BLUE,    -1)
    init_pair(CYAN,    Color::CYAN,     0) # for status)
    init_pair(YELLOW,  Color::YELLOW,  -1)
    noecho
    curs_set 2
    ch = 0

    Screen.init
    form = Form.new
    form.load_file
    form.draw
    while ch != KEY_CTRL_Q
      ch = wgetch stdscr
      if ch == KEY_RESIZE
        ch = nil
        endwin
        Screen.init
        Form.init
        Form.shift
      end
      form.update ch
      form.draw
      doupdate
      wrefresh stdscr
    end
  rescue => err
  ensure
    endwin
    Seed.discard
    puts err
    abort
  end
end
