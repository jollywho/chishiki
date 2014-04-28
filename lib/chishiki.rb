#!/usr/bin/env ruby
#
#
require 'ffi-ncurses'
include FFI::NCurses
begin
  initscr
  raw
  keypad stdscr, true
  noecho
  curs_set 0
  ch = 0
  name = "none"
  # while ch != 27                # Escape
  while ch != KEY_CTRL_Q
    refresh
    ch = wgetch stdscr
    if ch == KEY_ENTER
      clear
    end
    waddch stdscr, ch | A_UNDERLINE
  end
ensure
  endwin
end
