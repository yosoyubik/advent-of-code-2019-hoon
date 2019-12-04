::  --- Day 4: Secure Container ---
::  You arrive at the Venus fuel depot only to discover it's protected by a
::  password. The Elves had written the password on a sticky note, but someone
::  threw it out.
::
::  However, they do remember a few key facts about the password:
::
::  It is a six-digit number.
::  The value is within the range given in your puzzle input.
::  Two adjacent digits are the same (like 22 in 122345).
::  Going from left to right, the digits never decrease; they only ever increase
::  or stay the same (like 111123 or 135679).
::  Other than the range rule, the following are true:
::
::  111111 meets these criteria (double 11, never decreases).
::  223450 does not meet these criteria (decreasing pair of digits 50).
::  123789 does not meet these criteria (no double).
::  How many different passwords within the range given in your puzzle input
::  meet these criteria?
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
  ::  ~&  (six-digits a)
  ::  ~&  +:(dup a)
  ::  ~&  +:(increase a)
  ::  ~&  (range (scan a dem))
  ?&  (six-digits a)
      +:(dup a)
      +:(increase a)
      ::  (range (scan a dem))
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
  ^-  [@t ?]
  %+  roll  a
  |=  [a=@t [b=@t d=?]]
  ^-  [@t ?]
  ?:  =(b '')  [a %.n]
  [a |(d =(a b))]
--
