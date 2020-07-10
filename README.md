# Safe spaces

For a checkers board `[[R|B|E, ...], ...]` where

+ R represents a red piece
+ B represents a black piece
+ E represents an empty space

determine if any piece is in danger of attack.

Adapted from a [solution](http://dalrym.pl/notes/safe-spaces.html) I wrote in Q. Wanted to see how the array-centric concepts from APL/J/K/Q worked in Haskell. Additionally benefits from ADTs and Monads of course. Attempted to be as tacit as possible. Presented as a fun curiosity.
