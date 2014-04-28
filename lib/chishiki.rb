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
    lbl2 = Label.new(
      :pos => Pos.new(19, 9))
    $form.add lbl2
    lbl2.msg_i = 97
    $form.set_focus lbl
    while ch != KEY_CTRL_Q
      refresh
      ch = wgetch stdscr
      $log.debug ch
        $form.draw
      if ch == 127
        px = getyx stdscr
        $log.debug px
        mvwdelch stdscr, px[0], px[1]-1
      else
        lbl.msg_i = ch
      end
    end
  rescue => err
  ensure
    endwin
    $log.debug err
  end
end
