open Minigame
open Buildings
open Hangman 

(** [MakeGame] is an instance of the functor [MiniGameMaker] that creates a [Minigame]
    using [Mini]xs*)
module MakeGame : MiniGameMaker 

(** [GameOne] is a Minigame that has [Hangman] as its Game field.*)
module GameOne :  Minigame

(** [hangman_game()] is the function that starts the Minigame Hangman*)
val hangman_game :  unit -> int

(** [GameTwo] is a Minigame that has [Buildings] as its Game field.*)
module GameTwo : Minigame

(** [building_game()] is the function that starts the Minigame Buildings*)
val building_game : unit -> int 

(** [l] is the array that stores the functions that start the available
    Minigames*)
val l : (unit -> int) array