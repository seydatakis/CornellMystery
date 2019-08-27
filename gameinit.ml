open Minigame
open Buildings
open Hangman 

module MakeGame : MiniGameMaker = functor (M:Mini) ->
struct
  module Game = M
end

module GameOne = MakeGame(Hangman)

let hangman_game = GameOne.Game.game

module GameTwo = MakeGame(Buildings)

let building_game = GameTwo.Game.game

let l = [|hangman_game; building_game |]
