open ANSITerminal
open Minigame

(** [Hangman] is  a module that stores the game that asks the player to enter 
    letters and correctly guess the name of a Cornell hall. The player loses if they 
    enter more than 4 incorrect letters, and wins if the word is complete with less
    than 5 incorrect guesses. The game returns 20 points to be added to the 
    overall score if won. This module is used later in gameinit.ml
    to create GameOne.*)
module Hangman : Mini