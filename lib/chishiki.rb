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
    keypad stdscr, true
    noecho
    curs_set 1
    ch = 0

    $form = Form.new
    lbl = Label.new(
      :pos => Pos.new(5,5))
    $form.add lbl
    $form.set_focus lbl
    while ch != KEY_CTRL_Q
      ch = wgetch stdscr
      $log.debug ch
      if ch == 127
        lbl.del
      else
      lbl.msg_i = ch
        $form.draw
      end
      refresh
    end
  rescue => err
  ensure
    endwin
    $log.debug err
  end
end
