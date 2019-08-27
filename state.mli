(** 
   Representation of dynamic game state.

   This module represents the state of a mystery as it is being played,
   including the player's current square on the board,
   and functions that cause the state to change.
*)

(** The type of values representing the game state. *)
type state 

(** [init_state] is the initial state of the game. *)
val init_state : state 

(** [get_square st] is the current square in st *)
val get_square : state -> int

(** [increment_score curr_state x] increments the current score by [x] *)
val increment_score : state -> int -> unit

(** [get_game st] is the part of the story that is left in the current state *)
val get_game : state -> Story.t

(** [get_items st] is the association list of items and costs that are still
    available at the store *)
val get_items : state -> (string * int) list

(** [score curr_state] is the player's current score in the given state 
    [curr_state]. *)
val score: state -> unit

(** [inventory curr_state valid] displays the contents of the player's current 
    inventory and allows the player to use items if they wish*)
val inventory: state -> bool -> unit

(** [display_store list] shows all the items and their associated costs
    that are available for sale at the store. *)
val display_store : (string * int) list -> unit

(** [generate_rand_sus] is the list of two randomly generated suspects *)
val generate_rand_sus : unit -> string list

(** [chance valid state sus_lst] generates a chance card and handles its features, including
    talking to the suspects in the game.*)
val chance: bool -> state -> string list -> unit

(** [roll] updates the state of the player after rolling the dice. *)
val roll: state -> unit

(** [guess curr_state] keeps track of the number of guesses that a player has 
    made, and the accuracy of those guesses. *)
val guess: state -> bool -> bool * int

(** [buy curr_state] handles the process of buying a square property in a given 
    state. *)
val buy: state -> unit

(** [purchase item_name curr_state] is the effect of the player purchasing an 
    item [item_name] in the current state [curr_state], and the updated state of 
    play following the purchase. *)
val purchase : string -> state -> unit 
