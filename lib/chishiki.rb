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
    use_default_colors 
    noecho
    curs_set 2
    ch = 0

    $form = Form.new
    $form.draw
    t = Time.now
    while ch != KEY_CTRL_Q
      if t.to_f > SLEEPTIME
      t1 = Time.now
      ch = wgetch stdscr
      $log.debug ch
      $form.update ch
      $form.draw
      doupdate
      wrefresh stdscr
      end
    end
  rescue => err
  ensure
    endwin
    $log.debug err
  end
end
