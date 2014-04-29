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
    curs_set 2
    ch = 0

    $form = Form.new
    init_txt = Text.new(
      :pos => Pos.new(5,5))
    $form.add init_txt
    $form.set_focus init_txt
    while ch != KEY_CTRL_Q
      ch = getch
      $log.debug ch
      clear
      $form.update ch
      $form.draw
    end
  rescue => err
  ensure
    endwin
    $log.debug err
  end
end
