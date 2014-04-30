#!/usr/bin/env ruby
#
#
require 'ffi-ncurses'
require 'logger'
include FFI::NCurses
module Chishiki
  Dir["./chishiki/*.rb"].each {|file| require file}
  $log = Logger.new("log")
  $log.debug "***************"
  begin
    initscr
    raw
    start_color
    use_default_colors 
    noecho
    curs_set 2
    ch = 0

    $form = Form.new
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
