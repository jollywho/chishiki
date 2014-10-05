Chishiki - 知識
=================
```
     o          o      o
     |    o     |    o | /  o
 o-o O--o   o-o O--o   OO
|    |  | |  \  |  | | | \  |
 o-o o  o | o-o o  o | o  o |
```

A command-line program to write and track notes using branches.

Requires
==
ruby
ffi-ncurses https://github.com/seanohalpin/ffi-ncurses

Usage
==
chi <filename>

Keys
==
o - new child branch
O - new sibling branch (same parent)
D - delete branch
S - save file
C-d - quit
a - enter edit mode
escape - exit edit mode (normal mode)

Movement (normal mode)
h - to parent (uses k if no parent)
j - next branch down
k - next branch up
l - to sibling (uses j if no sibling)

Edit Mode
C-W  kill-word backwards

Issues
======

Please report any issues on the https://github.com/jollywho/chishiki/issues page.

Cursor flicker is a known issue with no fix in sight. If you know of a way to fix this, let the author know.
