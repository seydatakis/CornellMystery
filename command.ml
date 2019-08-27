
type object_phrase = string list

type command = 
  | Roll
  | Guess
  | Score
  | Inventory
  | Buy
  | Purchase of object_phrase
  | Quit
  | Help

exception Empty

exception Malformed

(** [parse_quit lst] is Quit if lst is an empty list, otherwise raises 
    [Malformed]
    Raises: [Malformed] if lst isn't an empty list *)
let parse_quit lst = 
  match lst with 
  | [] -> Quit
  | _ -> raise(Malformed)

(** [parse_score lst] is Score if lst is an empty list, otherwise raises 
    [Malformed]
    Raises: [Malformed] if lst isn't an empty list *)
let parse_score lst = 
  match lst with 
  | [] -> Score
  | _ -> raise(Malformed)

(** [parse_inventory lst] is Inventory if lst is an empty list, 
    otherwise raises [Malformed]
    Raises: [Malformed] if lst isn't an empty list *)
let parse_inventory lst = 
  match lst with 
  | [] -> Inventory
  | _ -> raise(Malformed)

(** [parse_roll lst] is (Roll lst) if lst is empty,
    otherwise raises [Malformed]
    Raises: [Malformed] if [lst] isn't an empty list *)
let parse_roll lst = 
  match lst with
  | [] -> Roll
  | _ -> raise(Malformed)

(** [parse_guess lst] is (Guess lst) if lst is empty, 
    otherwise raises [Malformed]
    Raises: [Malformed] if [lst] isn't an empty list *)
let parse_guess lst = 
  match lst with
  | [] -> Guess
  | _ -> raise(Malformed)

(** [parse_buy lst] is (Buy lst) if lst is empty, 
    otherwise raises [Malformed]
    Raises: [Malformed] if [lst] isn't an empty list *)
let parse_buy lst = 
  match lst with
  | [] -> Buy
  | _ -> raise(Malformed)

(** [parse_purchase lst] is (Purchase lst) if lst is not empty, 
    otherwise raises [Malformed]
    Raises: [Malformed] if [lst] is an empty list *)
let parse_purchase lst = 
  match lst with
  | [] -> raise Malformed
  | _ -> Purchase lst 

(** [parse_help lst] is (Help lst) if lst is not empty, 
    otherwise raises [Malformed]
    Raises: [Malformed] if [lst] is an empty list *)
let parse_help lst = 
  match lst with
  | [] -> Help
  | _ -> raise Malformed

(** [parse_words_list lst] performs the function of parse.
    Requires: [lst] is a list of the words in the [str] argument of parse *)
let parse_words_list lst = 
  match lst with
  | [] -> raise(Empty)
  | h::t -> if h = "quit" then parse_quit t
    else if h = "score" then parse_score t
    else if h = "inventory" then parse_inventory t
    else if h = "roll" then  parse_roll t
    else if h = "guess" then  parse_guess t
    else if h = "buy" then parse_buy t 
    else if h = "purchase" then parse_purchase t
    else if h = "help" then parse_help t
    else raise(Malformed)

(** [split_words str] is a list of the words in [str] where words are the
    sequences delimited by one or more characters *)
let split_words str =
  List.filter (fun x -> not (x = "")) (String.split_on_char ' ' str)

let parse str =
  parse_words_list (
    split_words str
  )

