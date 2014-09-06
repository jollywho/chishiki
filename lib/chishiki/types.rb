module Chishiki
  TYPES = {
    :head => "￭─o",
    :body => "│─o",
    :tail => "└─o",
  }
  CHAR_WPIPE = TYPES[:body][1]
  CHAR_VPIPE = TYPES[:body][0]
  MARKER_F_E = '❯'
  MARKER_F_N = '/'
  MARKER_N_N = ' '
  PIPE_WIDTH = -18
  MARKER_WIDTH = -1
  NODE_WIDTH = -3
  PIPE_SIZE = 17
  NODE_START = PIPE_WIDTH + NODE_WIDTH
end
