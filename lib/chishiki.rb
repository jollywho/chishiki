#!/usr/bin/env ruby
#
#
require 'ffi-ncurses'
require 'logger'
include FFI::NCurses
require './chishiki' #todo: require entire lib folder?
module Chishiki
  $log = Logger.new("log")
begin
  $form = Form.new
  $form.add Label.new(
    :pos => Pos.new(5,5))
  initscr
  raw
  start_color
  use_default_colors 
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
end
