open Mystery
open State
open Command
open Story
open ANSITerminal
open Gameinit

(** [play_game map state] handles all player interactions with the mystery 
    storyboard, including input commands and states, given a valid state 
    and a storyboard. *)
let rec play_game map state = 

  try
    let command = Command.parse (read_line ()) in
    begin
      match command with
      | Help -> (Pervasives.print_string "\n\nMove around the map by using"); 
        (print_string [green] " roll"); 
        (Pervasives.print_string ".\nView your inventory using ");
        (print_string [green] "inventory");
        (Pervasives.print_string  ".\nView your score by"); 
        (print_string [green] " score");
        (Pervasives.print_string ".\nBuy a location by using ");
        (print_string [green] "buy");
        (Pervasives.print_string ". For each location owne\nAt any time you can quit using "); 
        (print_string [green] "quit");
        (Pervasives.print_string ".\nYou can guess at any point using");
        (print_string [green] " guess");
        (Pervasives.print_string 
           ", but your supervisor will only allow you to guess 3 times.\n");
        play_game map state
      | Purchase x -> 
        if (Mystery.get_type (State.get_square state)) = Store then 
          match command with 
          |Purchase x -> 
            purchase (String.concat " " x) state; 
            play_game map state
          |_ -> 
            print_string[red] "That was invalid. Please try again.\n";
            play_game map state;

        else (
          print_string [red] "You can only buy on when you are at the store.";
          print_endline "";
          play_game map state)

      | Roll -> roll state; 
        print_endline (display_board (State.get_square state) 0 board_map);
        scroll 5;      
        let new_square_type = (Mystery.get_type (State.get_square state)) in
        begin
          match new_square_type with
          |Start ->  ();   
            play_game map state 
          |Chance -> 
            print_string [default] "You landed on a chance square! ";
            print_string [default] "We'll first play a mini game.";
            print_string [default] " Then you get to ask a suspect a question.\n";
            let ranint =
              Random.self_init(); Random.int 2 in
            let add_s = Gameinit.l.(ranint)() in
            State.increment_score state add_s;
            chance true state (State.generate_rand_sus ());
            play_game map state 
          |Regular -> 
            begin
              try 
                print_string [blue] (Story.peek (State.get_game state));
                print_endline "";
                print_endline "";
                Story.pop (State.get_game state);     play_game map state
              with 
              | Empty ->
                print_string [red] 
                  "You are at the end of the game. \n";
                print_string [red] 
                  "Your supervisor calls you and he needs an answer now. \n"; 
                print_string [red] 
                  "You have one chance to get it right.\n";
                let answer = State.guess state true in
                begin 
                  match answer with
                  |(true,_) -> 
                    print_string [green] "\nCongratulations, you have correctly guessed. You win!";
                    print_endline "";
                    print_endline "However, we have some bad news:
            You received a call from your supervisor, telling you that it was not
            a murder after all. The autopsy showed that the student had a heart attack, 
            which was probably due to the CS3110 grade you saw on their phone.
            So sad for the student, and such a waste of time for you."; 
                    exit 0;
                  |(false,y) -> 
                    print_string [red] "\nThat was incorrect. Game over! You are fired.";
                    print_endline "";
                    print_endline "However, we have some bad news:
                You received a call from your supervisor, telling you that it was not 
                a murder after all. The autopsy showed that the student had a heart attack, 
                which was probably due to the CS3110 grade you saw on their phone.
                So sad for the student, and such a sad reason for you to lose your first job."; 
                    exit 0;
                end
            end
          | Store -> 
            print_endline "You are at the store.";
            print_string [default] "You can purchase an item using ";
            print_string [green] "purchase ";
            print_string [default] "and the ";
            print_string [green] "item "; 
            print_string [default] "name. \n"; 

            display_store (get_items state); 
            print_endline "";
            play_game map state;
        end

      | Guess -> 
        begin 
          let answer = guess state true in
          match answer with
          |(true,_) -> 
            print_string [green] "\nCongratulations, you have correctly guessed. You win!";
            print_endline "";
            print_endline "However, we have some bad news:
            You received a call from your supervisor, telling you that it was not
            a murder after all. The autopsy showed that the student had a heart attack, 
            which was probably due to the CS3110 grade you saw on their phone.
            So sad for the student, and such a waste of time for you."; 
          |(false,y) -> 
            if y > 2 then 
              begin
                print_string [red] "\nThat was incorrect. Game over! You are fired.";
                print_endline "";
                print_endline "However, we have some bad news:
                You received a call from your supervisor, telling you that it was not 
                a murder after all. The autopsy showed that the student had a heart attack, 
                which was probably due to the CS3110 grade you saw on their phone.
                So sad for the student, and such a sad reason for you to lose your first job."; 
                exit 0;
              end
            else print_string [red] 
                "That was incorrect. You may guess again now or later."; 
            print_endline "";
            play_game map state
        end
      | Score -> score state; play_game map state
      | Inventory -> inventory state true; play_game map state
      | Buy -> buy state; play_game map state
      | Quit -> print_endline "Bye."; exit 0
    end
  with _ -> 
    print_string [red] 
      "\nThis is an invalid command. Please enter a valid command.\n";
    print_string[red] 
      "These are roll, score, inventory, buy, quit, and guess. \n";
    print_endline "";
    play_game map state

(** [main ()] prompts for the game to play, then starts it. *)
let main () =
  resize 100 300;
  scroll 100;
  print_string [red] "You are an FBI agent and a recent Cornell grad.\n"; 
  print_string [red] "There has been a murder on campus.\n";
  print_string [red] "Your supervisor has assigned you to the case.\n";
  print_string [red] "This is your chance to prove yourself.\n";
  print_string [red] 
    "You need to find out who the killer is, as well as what the weapon is.\n";
  (Pervasives.print_string "\n\nMove around the map by using"); 
  (print_string [green] " roll"); 
  (Pervasives.print_string ".\nView your inventory using ");
  (print_string [green] "inventory");
  (Pervasives.print_string  ".\nView your score by"); 
  (print_string [green] " score");
  (Pervasives.print_string ".\nBuy a location for 20 points by using ");
  (print_string [green] "buy");
  (Pervasives.print_string ". Each time you roll, you will get 5pts per owned square");
  (Pervasives.print_string ".\nAt any time you can quit using "); 
  (print_string [green] "quit");
  (Pervasives.print_string ".\nYou can guess at any point using");
  (print_string [green] " guess");
  (Pervasives.print_string 
     ", but your supervisor will only allow you to guess 3 times.\n");
  print_endline "";
  print_endline (display_board 0 0 board_map);
  let mystery_map = Mystery.init_mystery in
  let start_state = State.init_state in 
  play_game mystery_map start_state

(* Execute the game engine. *)
let () = main ()
