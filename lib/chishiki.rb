#!/usr/bin/env ruby
#
#
require 'ffi-ncurses'
require 'logger'
include FFI::NCurses
  $log = Logger.new("log")
begin
  
  initscr
  raw
  start_color
  keypad stdscr, true
  noecho
  curs_set 1
  ch = 0
  name = "none"
  # while ch != 27                # Escape
  while ch != KEY_CTRL_Q
    refresh
    doupdate
    ch = wgetch stdscr
    $log.debug ch
    if ch == KEY_BACKSPACE || ch == KEY_DC || ch == 127
      px = getyx stdscr
      $log.debug px
      mvwdelch stdscr, px[0], px[1]-1
      $log.debug :yup
    else
      waddch stdscr, ch
    end
  end
rescue => err
ensure
  endwin
  $log.debug err
end
