(** 
   Representation of mystery storyboard data.

   This module represents the data stored on the mystery storyboard, including
   the rooms (i.e. board squares), suspects, weapons, items, questions, and NPCs.
   It handles loading of that data as well as querying the data.
*)

(** The type of values representing the style of room squares. *)
type room_style = 
  |Start
  |Chance
  |Regular
  |Store

(** The type of values representing the name of an item. *)
type item_name = string

(** The type of values representing the price of an item. *)
type item_points = int

(** The abstract type of values representing an item. *)
type item = item_name * item_points 

(** The type of values representing the journal item. *)
type journal = string list

(* [init_mystery] creates the initial mystery storyboard and each of the squares
   on it. *)
val init_mystery : room_style array

(** [suspect_list] is a string array of all possible suspects that can be 
    guessed. *)
val suspect_list : string array

(** [weapon_list] is a string array of all possible weapons that can be 
    guessed. *)
val weapon_list : string array

(** [weapon_list] is a string list of all possible questions that can be asked. *)
val question_list : string list

(** [chimesmaster] is a string array of possible answers given to the player by 
    the Chimesmaster NPC. *)
val chimesmaster : string array 

(** [dave] is a string array of possible answers given to the player by 
    the Happy Dave NPC. *)
val dave : string array 

(** [gries] is a string array of possible answers given to the player by 
    the Grees NPC. *)
val grees : string array

(** [foster] is a string array of possible answers given to the player by 
    the Floster NPC. *)
val floster : string array

(** [get_type room_num] is the type of a given room as represented by its 
    number [room_num]. *)
val get_type : int -> room_style 

(** [items_list] is list of items that are initially available for purchase. *)
val items_list : (string*int) list 

(* [board_map] holds the string representation of every possible
   layout in the game. *)
val board_map : string list

(* [display_board num acc map] returns the layout of the map at a given [num]
   with a starting [acc] for the [map]. *)
val display_board : int -> int -> string list -> string

(** [board_map] contains all possibly visual displays of the board*)
val board_map : string list



