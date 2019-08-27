
(** [Mini] is the module type that each game needs to fit into, which consists
    of a word directory [dir] and the function that starts the game, [game]*)
module type Mini= sig
  val dir : string array
  val game : unit -> int
end

(**[Minigame] is the type of the minigame that has a main Game component, which is 
   type Mini. This helps to incorporate the minigames in to the main game as a
    closed outside component *)
module type Minigame= sig
  module Game : Mini
end 

(** [MiniGameMaker] is a functor that creates an instance of a Minigame using module 
    [M] as the Game.*)
module type MiniGameMaker = functor (M : Mini) ->
  Minigame with module Game = M