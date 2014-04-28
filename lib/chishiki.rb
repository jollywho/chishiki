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
  newl = getyx stdscr
  # while ch != 27                # Escape
  while ch != KEY_CTRL_Q
    refresh
    ch = wgetch stdscr
    $log.debug ch
    if ch == 127
      px = getyx stdscr
      $log.debug mvwinch stdscr, px[0], px[1]-1
      mvwdelch stdscr, px[0], px[1]-1
      move(newl[0], newl[1]) #move to prev saved line, either from carriage return or exceeding text width
    else
      if ch == 10
        newl = getyx stdscr
      end
      waddch stdscr, ch
    end
  end
rescue => err
ensure
  endwin
  $log.debug err
end
