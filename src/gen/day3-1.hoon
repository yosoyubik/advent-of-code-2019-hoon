::  --- Day 3: Crossed Wires ---
::  The gravity assist was successful, and you're well on your way to the Venus
::  refuelling station. During the rush back on Earth, the fuel management system
::  wasn't completely installed, so that's next on the priority list.
::
::  Opening the front panel reveals a jumble of wires. Specifically, two wires are
::  connected to a central port and extend outward on a grid. You trace the path
::  each wire takes as it leaves the central port, one wire per line of text
::  (your puzzle input).
::
::  The wires twist and turn, but the two wires occasionally cross paths. To fix
::  the circuit, you need to find the intersection point closest to the central
::  port. Because the wires are on a grid, use the Manhattan distance for this
::  measurement. While the wires do technically cross right at the central port
::  where they both start, this point does not count, nor does a wire count as
::  crossing with itself.
::
::  For example, if the first wire's path is R8,U5,L5,D3, then starting from the
::  central port (o), it goes right 8, up 5, left 5, and finally down 3:
::
::  ...........
::  ...........
::  ...........
::  ....+----+.
::  ....|....|.
::  ....|....|.
::  ....|....|.
::  .........|.
::  .o-------+.
::  ...........
::  Then, if the second wire's path is U7,R6,D4,L4, it goes up 7, right 6, down 4,
::   and left 4:
::
::  ...........
::  .+-----+...
::  .|.....|...
::  .|..+--X-+.
::  .|..|..|.|.
::  .|.-X--+.|.
::  .|..|....|.
::  .|.......|.
::  .o-------+.
::  ...........
::  These wires cross at two locations (marked X), but the lower-left one is
::  closer to the central port: its distance is 3 + 3 = 6.
::
::  Here are a few more examples:
::
::  R75,D30,R83,U83,L12,D49,R71,U7,L72
::  U62,R66,U55,R34,D71,R55,D58,R83 = distance 159
::  R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
::  U98,R91,D20,R16,D67,R40,U7,R15,U6,R7 = distance 135
::  What is the Manhattan distance from the central port to the closest
::  intersection?
::
/+  *day3
::
:-  %say
|=  *
=<  :-  %noun
    =/  w1=(list [cord @])  (parse-wire wire-1)
    =/  w2=(list [cord @])  (parse-wire wire-2)
    =/  center  [--0 --0]
    =-  (sort - lth)
    %+  turn
      =-  (skip - |=(c=[@sd @sd] =([--0 --0] c)))
      =-  ~(tap in -)
      %-  ~(int in (cover-grid w1))
      (cover-grid w2)
    |=  c=[@sd @sd]
    ^-  @
    (manhattan c center)
::
|%
++  parse-wire
  |=  w=tape
  ^-  (list [cord @])
  =-  (weld ~[-:-] +:-)
  (scan w (more (just ',') ;~(plug alf dem)))
::
++  cover-grid
  |=  w=(list [@t @])
  ^-  (set [@sd @sd])
  =/  c  [--0 --0]
  %-  sy
  |-  ^-  (list [@sd @sd])
  ?~  w  ~
  =/  path=(list [@sd @sd])
  %.  [c (gulf 0 +.i.w)]
  ?:  =(-.i.w 'U')
    up:go
  ?:  =(-.i.w 'R')
    right:go
  ?:  =(-.i.w 'D')
    down:go
  ?.  =(-.i.w 'L')  !!
    left:go
  %+  weld
    path
  $(w t.w, c (snag (dec (lent path)) path))
::
++  manhattan
  |=  [x=[@sd @sd] y=[@sd @sd]]
  ^-  @ud
  %+  add
    (abs:si (dif:si -.x -.y))
  (abs:si (dif:si +.x +.y))
::
++  go
  |%
  ++  up
    |=  [c=[@sd @sd] l=(list @)]
    %+  turn  l
    |=  y=@
    [-.c (sum:si +.c (sun:si y))]
  ::
  ++  down
    |=  [c=[@sd @sd] l=(list @)]
    %+  turn  l
    |=  y=@
    [-.c (dif:si +.c (sun:si y))]
  ::
  ++  right
    |=  [c=[@sd @sd] l=(list @)]
    %+  turn  l
    |=  x=@
    [(sum:si -.c (sun:si x)) +.c]
  ::
  ++  left
    |=  [c=[@sd @sd] l=(list @)]
    %+  turn  l
    |=  x=@
    [(dif:si -.c (sun:si x)) +.c]
  --
--
