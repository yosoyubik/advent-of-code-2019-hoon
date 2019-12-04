::  --- Part Two ---
::  An Elf just remembered one more important detail: the two adjacent matching
::  digits are not part of a larger group of matching digits.
::
::  Given this additional criterion, but still ignoring the range rule, the
::  following are now true:
::
::  112233 meets these criteria because the digits never decrease and all
::  repeated digits are exactly two digits long.
::  123444 no longer meets the criteria (the repeated 44 is part of a larger group
::    of 444).
::  111122 meets the criteria (even though 1 is repeated more than twice, it still
::    contains a double 22).
::  How many different passwords within the range given in your puzzle input meet
::  all of the criteria?
::
:-  %say
|=  *
=<  :-  %noun
    %-  lent
    %+  skim  (gulf 138.241 674.034)
    |=  a=@
    ^-  ?
    %-  criteria
    =-  (trip -)
    =-  ?>(?=([%n *] -) p.-)
    (numb:enjs:format a)
::
|%
++  criteria
  |=  a=tape
  ^-  ?
  ?&  (six-digits a)
      (dup a)
      +:(increase a)
       (range (scan a dem))
  ==
::
++  six-digits
  |=  a=tape
  ^-  ?
  =(6 (lent a))
::
++  range
  |=  a=@
  ^-  ?
  &((gte a 138.241) (lte a 674.034))
::
++  increase
  |=  a=tape
  ^-  [@t ?]
  %+  roll  a
  |=  [a=@t [b=@t f=?]]
  ^-  [@t ?]
  ?:  =(b '')  [a %.y]
  [a &(f (gte a b))]
::
++  dup
  |=  a=tape
  ^-  ?
  =-  |(a =(b 2))
  ^-  [@t a=? b=@]
  %+  roll  a
  |=  [c=@t [p=@t d=? r=@]]
  ^-  [@t ? @]
  ?:  =(p '')  [c %.n 1]
  :-  c
  ?:  =(c p)
    [d +(r)]
  [|(d =(r 2)) 1]
--
