#!/usr/bin/env ruby
#
#
require 'ffi-ncurses'
require 'logger'
include FFI::NCurses
module Chishiki
  Dir["./chishiki/*.rb"].each {|file| require file}
  $log = Logger.new("log")
  begin
    initscr
    raw
    start_color
    use_default_colors 
    noecho
    curs_set 1
    ch = 0

    $form = Form.new
    lbl = Text.new(
      :pos => Pos.new(5,5))
    $form.add lbl
    $form.set_focus lbl
    while ch != KEY_CTRL_Q
      ch = wgetch stdscr
      $log.debug ch
        $form.update ch
        $form.draw
      end
    clear
      doupdate
      refresh
  rescue => err
  ensure
    endwin
    $log.debug err
  end
  end
