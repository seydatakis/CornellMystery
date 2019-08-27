open Mystery
open Story 
open ANSITerminal


type state = {mutable score: int; 
              mutable guesses: int; mutable square: int; 
              mutable inventory: string list; 
              mutable items: (string * int) list;
              mutable journal: string list;
              mutable owned : int list; game: Story.t }

let get_square st = st.square

let get_game st = st.game

let get_items st = st.items

let init_state = {score = 0; guesses = 0; square = 0; inventory = []; 
                  items = Mystery.items_list; journal =[]; owned = [];
                  game = Story.init_story}

(** [print_list lst] is, given a string list of elements [lst], a string of 
    all elements of that list. *)
let rec print_list (lst:string list) = 
  match lst with
  |[] -> ()
  |h::t -> 
    print_string [blue; on_white] (h); 
    print_endline "";
    print_list t

(** [increment_score curr_state x] increments the current score by [x] *)
let increment_score curr_state x =
  curr_state.score <- curr_state.score + x

(** [roll_dice ()] is the sum of the result of rolling two die. *)
let roll_dice () = 
  Random.self_init();
  let first = (Random.int 6) + 1 in
  let second = (Random.int 6) + 1 in
  first + second 

(** [score curr_state] is the player's current score in the given state 
    [curr_state]. *)
let score (curr_state:state) = 
  print_string [magenta]"Your current score is ";
  print_int curr_state.score;
  print_newline()

(** [displayer list orderList] displays all options in a given state in a 
    pretty format*)
let rec displayer list orderList=
  match list with
  |[] -> ()
  |h::t -> 
    print_endline ((string_of_int(List.hd orderList) ^ " " ^ List.hd list));
    displayer t (List.tl orderList)

(** [make_order int acc] stores [int] consecutive integers in the [acc] 
    structure. *)
let rec make_order int acc = 
  if int > 0 then
    make_order (int-1) acc@[int]
  else acc

(** [print_and_journal answer message state] prints the [answer] and adds 
    the [message] to the journal in [state] if not already recorded. *)
let print_and_journal answer message state =
  print_string [cyan] answer;
  if List.mem "journal" state.inventory then
    if List.mem message state.journal then ()
    else state.journal <- message::state.journal 
  else ()

(** [display_answer data state] gives the appropriate answer to a question given a 
    character * question tuple [data] and adds it to the journal in [state]*)
let display_answer data state = 
  print_endline ("\nHe tells you that: ");

  match data with 
  |("Chimesmaster",y) -> 
    let answer = (Mystery.chimesmaster.(y-1)^"\n") in 
    let message = "Chimesmaster says " ^ (Mystery.chimesmaster.(y-1)) in 
    print_and_journal answer message state

  |("Happy Dave",y) -> 
    let answer = (Mystery.dave.(y-1)^ "\n") in
    let message = "Happy Dave says " ^ (Mystery.dave.(y-1)) in
    print_and_journal answer message state

  |("Grees",y) -> 
    let answer = (Mystery.grees.(y-1)^ "\n") in
    let message = "Grees says " ^ (Mystery.grees.(y-1)) in
    print_and_journal answer message state

  |("Floster",y) -> 
    let answer = (Mystery.floster.(y-1)^ "\n") in
    let message = "Floster says " ^ (Mystery.floster.(y-1)) in
    print_and_journal answer message state

  |_ -> failwith "will not enter here"

(** [item_user item_name state] is effect of using [item_name] in a given 
    [state].*)
let item_user item_name state = 
  if item_name = "binoculars" then 
    print_string [magenta] "You head to the top of the clock tower to get a better
view of the goings on at Cornell.
Is that Grees you see skulking at the bottom, by Olin Library?\n"
  else if item_name = "fingerprint testing kit" then 
    print_string [magenta] "You use it on all the physical evidence you have 
collected on campus so far. The only matches you have got so far are for 
the deceased student, Happy Dave, and the chimesmaster.\n"
  else if item_name = "tape recorder" then 
    print_string [magenta] "You use it to record the next conversation you have
 with a suspect on campus.\n"
  else if item_name = "night vision goggles" then 
    print_string [magenta] "You’ll put them on once the sun sets. With their help,
you wonder what new things you might be able to notice.\n"
  else if item_name = "lie detector" then 
    print_string [magenta] "You use it during the next conversation you have with
 a suspect on campus. Who knows who you can trust?\n"
  else if item_name = "spy camera" then 
    print_string [magenta] "It has photo- and video- taking features. You are testing
   its features to see how they work and accidentally take a photo facing yourself.
    Upon closer inspection of the image, you notice a blurry figure behind you. 
    Who could be following you?\n"
  else (print_string [green] "These are the notes in your journal: ";
        print_endline "";
        print_list state.journal)

(** [item_selector item inventory state] is the name of the item in the [item] 
    index in [inventory] in [state].*)
let rec item_selector item inventory state =
  match inventory with 
  |[] -> failwith "will not enter here"
  |h::t -> 
    if item = 0 then item_user h state
    else item_selector (item-1) t state

let rec inventory (curr_state: state) (valid:bool)= 
  if valid then
    begin
      if curr_state.inventory = [] then 
        (print_string [red] "Your inventory is empty.";
         print_string [red] "To leave the inventory, please type";
         print_string [green] " cancel\n";)
      else
        (print_endline "The following items are in your inventory:";
         displayer curr_state.inventory 
           (make_order (List.length curr_state.inventory) []);
         print_string [default] "To use an item type in ";
         print_string [green] "use";
         print_string [default] " followed by a ";
         print_string [green] "space ";
         print_string [default] "then the ";
         print_string [green] "number";
         print_string [default] " else type in ";
         print_string [green] "cancel " ;
         print_string [default] "to exit the inventory page. \n";)
    end

  else (print_string [red] "Invalid, please enter another input or type in ";
        print_string [green] "cancel " ;
        print_string [red] "to exit the inventory page. \n";);

  use_inventory curr_state;

and

  (**[use_inventory] allows the player to use the items opened in the 
     inventory in [state] *)
  use_inventory curr_state = 
  let input = String.lowercase_ascii( String.trim (read_line ())) in
  begin
    try
      if String.sub input 0 3 = "use" then (
        let item = (int_of_string (String.sub input 4 1) ) -1 in 
        item_selector item curr_state.inventory curr_state;
        use_inventory curr_state)

      else if input = "cancel" then 
        print_string [green] "\nExited inventory successfully. \n"

      else inventory curr_state false

    with
      _ -> inventory curr_state false;
  end

let rec display_store items_list = 
  match items_list with
  |[] -> ();
  |(x, y)::t -> 
    print_string [white; on_magenta] 
      ("-" ^ x ^ " for a cost of " ^ string_of_int y ^" points \n") ;
    display_store t

let purchase (item_name: string) (curr_state: state) = 
  if (List.mem_assoc item_name Mystery.items_list && 
      (List.mem item_name curr_state.inventory) = false) then begin
    let item_price = List.assoc item_name items_list in 
    if curr_state.score - item_price >= 0 then 
      begin
        curr_state.score <-curr_state.score - item_price;
        curr_state.items <- List.remove_assoc item_name (get_items curr_state);
        curr_state.inventory <- item_name::curr_state.inventory; 
        (print_string [green] 
           ("You have successfully purchased " ^ item_name ^ ". \n"));
        scroll 6;
        print_string [blue] "The following items are still available for purchase: \n";
        display_store curr_state.items;
        print_endline "";
      end
    else 
      (print_string [red] "You don't have enough money to make this purchase. \n")
  end
  else if (List.mem item_name curr_state.inventory) then 
    print_string [red] "You already have this item in your inventory."

  else 
    (print_string [red] "Invalid, please enter another input.\n";
     print_string [default] "You can ";
     print_string [green] "purchase "; 
     print_string [default] "an ";
     print_string [green] "item " ;
     print_string [default] "or continue the game.\n")

(** [display_questions person valid state] shows all the questions that a player 
    can ask a given NPC [person], checks if the question chosen by the player 
    is valid to ask, and deducts points depending on which question is chosen.
    If the input is valid, it returns the corresponding answer.*)
let rec display_questions (person:string) (valid:bool) (state:state)= 
  if valid then 
    begin
      print_string [default] 
        "\nYou may ask the suspect the following questions: \n";
      displayer  Mystery.question_list [1;2;3;4;5];
      print_endline "";
    end
  else 
    print_string [red] 
      "That was an invalid input. Please pick 1, 2, 3, 4 or 5. \n";
  print_endline "";
  try
    let input = read_int () in
    begin
      match input with 
      |x -> 
        if x > 0 && x < 6 then
          begin
            if (state.score - x*10) >= 0
            then 
              let new_score = state.score - (x*10) in 
              state.score <- new_score;
              display_answer (person, x) state ;
            else 
              (print_string [red] "You don't have enough points!\n";
               print_string [default] "The suspect has left, come back later.\n")
          end
        else display_questions person false state
      |exception (Failure s) -> display_questions person false state
    end
  with
  | Failure _-> display_questions person false state

(** [check_identical] checks if any two given suspects are identical. If they 
    are identical, then a new non-identical suspect is randomly generated. *)
let rec check_identical sus_one sus_two = 
  if sus_one = sus_two then 
    check_identical sus_one Mystery.suspect_list.(Random.int 4)
  else
    sus_two

let generate_rand_sus () = 
  let sus_one = Mystery.suspect_list.(Random.int 4) in
  let sus_two = Mystery.suspect_list.(Random.int 4) in
  let sus_two_updated = check_identical sus_one sus_two in
  [sus_one; sus_two_updated]

let rec chance valid curr_state sus_list= 
  if valid then 
    begin
      print_string [cyan] 
        "\nYou have the opportunity to talk to these suspects: \n";
      displayer sus_list (make_order (List.length sus_list) []);
      print_endline "";
    end
  else
    print_string [red] "That is not a valid choice. Please pick 1 or 2. \n";
  print_endline "";
  try
    let input = read_int() in
    match input with 
    | x -> 
      if x = 1  then display_questions (List.nth sus_list 0) true curr_state
      else if x = 2 then display_questions (List.nth sus_list 1) true curr_state
      else chance false curr_state sus_list
    | exception (Failure s) -> chance false curr_state sus_list
  with 
  | Failure _ -> chance false curr_state sus_list

let roll (curr_state:state) = 
  curr_state.score <- curr_state.score + (5*List.length curr_state.owned);
  let move = roll_dice() in 
  Pervasives.print_string "You rolled a ";
  print_int move;
  print_newline();
  let unadjusted = curr_state.square + move in 
  if unadjusted > 15 then let new_square = unadjusted mod 16 in
    curr_state.square <- new_square;
    (print_string [green] "You passed go and collected 50 points! \n");
    print_endline "";
    curr_state.score <- curr_state.score + 50;

  else let new_square = unadjusted in
    curr_state.square <- new_square

let rec guess (curr_state:state) (valid:bool) = 
  (if valid = true then 
     begin
       curr_state.guesses <- curr_state.guesses + 1;
       print_endline "\nChoose one of the options below:";
       print_endline "";
       print_endline "The killer is the Chimesmaster. ";
       print_string [blue] 
         "The weapon was: (1. Poison) (2. Push) (3. Banana) (4: iClicker)";
       print_endline " ";
       print_endline "\nThe killer is Happy Dave. ";
       print_string [blue] 
         "The weapon was: (5. Poison) (6. Push) (7. Banana) (8: iClicker)";
       print_endline "";
       print_endline "\nThe killer is Grees.";
       print_string [blue] 
         "The weapon was: (9. Poison) (10. Push) (11. Banana) (12: iClicker)";
       print_endline "";
       print_endline "\nThe killer is Floster.";
       print_string [blue] 
         "The weapon was: (13. Poison) (14. Push) (15. Banana) (16: iClicker)";
       print_newline();
       Pervasives.print_string "\nYou tell your supervisor it is option: ";
     end
   else 
     print_string [red] "This is an invalid input, please try again.\n";);

  begin
    try
      let input = read_int() in
      match input with 
      |2 -> (true, curr_state.guesses);
      |x -> 
        if x > 0 &&  x < 17 then (false, curr_state.guesses)
        else guess (curr_state) (false) 
      |exception (Failure s) -> guess (curr_state) (false); 
    with 
    | Failure _ -> guess (curr_state) (false); 
  end

let buy (curr_state: state) = 
  if (Mystery.get_type (curr_state.square) = Regular) && 
     curr_state.score >= 20 && 
     List.mem curr_state.square curr_state.owned = false then 
    begin 
      curr_state.owned <- curr_state.square::curr_state.owned;
      curr_state.score <- curr_state.score - 20;
      print_string [green]
        "You have sucessfully purchased this square. It cost 20 points. \n";
      print_string ([default]) 
        ("Current score: " ^ (string_of_int (curr_state.score)));
    end
  else if List.mem curr_state.square curr_state.owned = true then 
    print_string [red] 
      "This purchase is invalid. You already own the square."

  else if (Mystery.get_type (curr_state.square) <> Regular) then 
    print_string [red] 
      "This purchase is invalid. You can only buy regular squares."

  else print_string [red] 
      "This purchase is invalid. You don't have enough points!";
  print_endline ""


