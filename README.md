# CornellMystery
This is a text-based, Cornell-themed murder mystery game implemented in OCaml using modular programming.
It is a board-game where the player "rolls" dice and moves on the board to have different opportunities like
talking to some characters and asking questions and guess the murderer and the weapon.
The main game is composed of main.ml, state.ml, command.ml and story.ml. Story.ml draws the story from a text file, which allows the story to be modified. There are mini-games added to the game to collect more points, which are called buildings.ml and hangman.ml, and are turned into the same format by a functor in another file.

This was a midterm project for CS3110, designed and implemented from scratch by Seyda Takis, May Chen and Debasmita Bhattacharya.
