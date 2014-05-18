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
    init_pair(RED,     Color::RED,     Color::BLACK)
    init_pair(GREEN,   Color::GREEN,   Color::BLACK)
    init_pair(WHITE,   Color::WHITE,   Color::BLACK)
    init_pair(MAGENTA, Color::MAGENTA, Color::BLACK)
    init_pair(BLUE,    Color::BLUE,    Color::BLACK)
    init_pair(CYAN,    Color::CYAN,    Color::BLACK)
    init_pair(YELLOW,  Color::YELLOW,  Color::BLACK)
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
        form.init
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
