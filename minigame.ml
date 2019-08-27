module type Mini= sig
  val dir : string array
  val game : unit -> int
end


module type Minigame= sig
  module Game : Mini
end 

module type MiniGameMaker = functor (M : Mini) ->
  Minigame with module Game = M