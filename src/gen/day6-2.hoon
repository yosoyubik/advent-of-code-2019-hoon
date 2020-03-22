::  --- Day 6: Universal Orbit Map ---
::  You've landed at the Universal Orbit Map facility on Mercury. Because
::  navigation in space often involves transferring between orbits, the orbit
::  maps here are useful for finding efficient routes between, for example, you
::  and Santa. You download a map of the local orbits (your puzzle input).
::
::  Except for the universal Center of Mass (COM), every object in space is in
::  orbit around exactly one other object. An orbit looks roughly like this:
::
::                    \
::                     \
::                      |
::                      |
::  AAA--> o            o <--BBB
::                      |
::                      |
::                     /
::                    /
::  In this diagram, the object BBB is in orbit around AAA. The path that BBB
::  takes around AAA (drawn with lines) is only partly shown. In the map data,
::  this orbital relationship is written AAA)BBB, which means "BBB is in orbit
::  around AAA".
::
::  Before you use your map data to plot a course, you need to make sure it
::  wasn't corrupted during the download. To verify maps, the Universal Orbit
::  Map facility uses orbit count checksums - the total number of direct orbits
::  (like the one shown above) and indirect orbits.
::
::  Whenever A orbits B and B orbits C, then A indirectly orbits C. This chain
::  can be any number of objects long: if A orbits B, B orbits C, and C orbits D,
::  then A indirectly orbits D.
::
::  For example, suppose you have the following map:
::
::  COM)B
::  D)E
::  B)C
::  C)D
::  D)E
::  E)F
::  B)G
::  G)H
::  D)I
::  E)J
::  J)K
::  K)L
::
::  Visually, the above map of orbits looks like this:
::
::          G - H       J - K - L
::         /           /
::  COM - B - C - D - E - F
::                 \
::                  I
::  In this visual representation, when two objects are connected by a line, the
::  one on the right directly orbits the one on the left.
::
::  Here, we can count the total number of orbits as follows:
::
::  D directly orbits C and indirectly orbits B and COM, a total of 3 orbits.
::  L directly orbits K and indirectly orbits J, E, D, C, B, and COM, a total of
::  7 orbits.
::  COM orbits nothing.
::  The total number of direct and indirect orbits in this example is 42.
::
::  What is the total number of direct and indirect orbits in your map data?
::
/+  *day6
:-  %say
|=  *
=<  :-  %noun
    =/  graph=(map @t (unit @t))  (create-graph mapa)
    =/  you-list=(list @t)  (paths-to-goal graph 'YOU' 'COM')
    =/  san-list=(list @t)  (paths-to-goal graph 'SAN' 'COM')
    =/  goal=@t  (find-goal you-list san-list)
    %+  add
      (lent (paths-to-goal graph 'YOU' goal))
    (lent (paths-to-goal graph 'SAN' goal))
|%
++  create-graph
  |=  l=(list tape)
  =|  orbits=(map @t (unit @t))
  |-  ^-  (map @t (unit @t))
  ?~  l  orbits
  =/  path=[@t @t]
    =-  [(crip (limo -<)) (crip ->-)]
    (scan i.l (more (just ')') (star aln)))
  =/  center=(unit (unit @t))  (~(get by orbits) -.path)
  =/  outer=(unit (unit @t))  (~(get by orbits) +.path)
  =.  orbits
    =-  ?^  center
          -
        (~(put by -) [-.path ~])
      (~(put by orbits) [+.path `-.path])
  $(l t.l)
::
++  find-goal
|=  [aa=(list @t) bb=(list @t)]
=+  [a=(flop aa) b=(flop bb)]
=|  steps=@
|-  ^-  @t
?:  |(?=(~ a) ?=(~ b))
   'COM'
?.  =(i.a i.b)
  ?:  =(steps 0)  'COM'
  (snag (dec steps) (flop aa))
$(a t.a, b t.b, steps +(steps))
::
++  paths-to-goal
  |=  [graph=(map @t (unit @t)) init=@t goal=@t]
  |-  ^-  (list @t)
  =/  center=(unit @t)  (~(got by graph) init)
  ?~  center  ~&  init  ~
  ?:  =(u.center goal)  ~
  [u.center $(init u.center)]
--
