#!/usr/bin/env ruby
#
#
require 'ffi-ncurses'
require 'logger'
include FFI::NCurses
module Chishiki
  Dir["./chishiki/*.rb"].each {|file| require file}
  $log = Logger.new("log")
 # $log.level = Logger::ERROR
  $log.debug "***************"
  begin
    initscr
    raw
    start_color
    init_pair(1,  Color::RED,     Color::BLACK)
    init_pair(2,  Color::GREEN,  Color::BLACK)
    init_pair(3,  Color::WHITE,   Color::BLACK)
    init_pair(4,  Color::MAGENTA, Color::BLACK)
    noecho
    curs_set 2
    ch = 0

    $form = Form.new
    $form.draw
    while ch != KEY_CTRL_Q
      ch = wgetch stdscr
      $log.debug ch
      $form.update ch
      $form.draw
      doupdate
      wrefresh stdscr
    end
  rescue => err
  ensure
    endwin
    $log.debug err
  end
end
