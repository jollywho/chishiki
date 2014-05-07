module Chishiki

  TYPES = {
    :head => "￭─o",
    :body => "├─o",
    :tail => "└─o",
  }
  CHAR_WPIPE = '─'
  CHAR_VPIPE = '│'
  TEXTWIDTH = 40
  TEXTHEIGHT = 1
  PIPEWIDTH = -20
  NODEWIDTH = -3
  NODESTART = PIPEWIDTH + NODEWIDTH
  SLEEPTIME = 1.0/24.0

  COLOR_VPIPE = key('|') | COLOR_PAIR(3)
  COLOR_WPIPE = key('-') | COLOR_PAIR(1)
end
