open ANSITerminal

module Buildings = struct
  (**[dir] is the string array that stores the directory of halls at Cornell. *)
  let dir = 
    [|"anabel taylor";"balch";"beebe"; "bradfield";
      "boldt";"bard";"barnes";"basic science";"biotechnology";"bartels";"barton";
      "cascadilla";"caldwell";"clark";"comstock";"carpenter";"court residence";
      "day";"clara dickson";"donlon";"duffield";"emerson";"goldwin smith";"gates";
      "hollister"; "human ecology";"helen newman";"ives";"klarman";"kimball";"kennedy";
      "kinzelberg";"lincoln";"lyon";"mcfaddin";"mcgraw";"mews";"milstein";"malott";
      "morill";"morrison";"hughes";"myron taylor";"m van rensselaer";"olin"; "phillips";
      "psb";"roberts";"rice";"rockefeller";"rhodes";"rand";"riley-robb";
      "risley";"sibley"; "sage";"snee";"schurman";"stocking";"statler";"stimson";
      "savage";"teagle";"thurston";"olive tjaden";"upson";"uris";"white";"weill";
      "wing";"warren"; "willard straight"|]

  (** [len] is the length of the array [dir] *)
  let len= Array.length dir 

  (** [curr_score] is the current score of the player that is initialized as 0 and
      incremented each time the player correctly guesses a building by 1.*)
  let curr_score = [|0|]

  (** [game()] is the function that runs the Buildings game*)
  let game () = 

    print_endline "Enter as many Cornell halls as you can, one by one. 
No need to write 'Hall', you have 60 seconds.";

    (* Sleep for 3 seconds to give the user time to read instructions.*)
    Unix.sleep 3;
    (* [curr_stat.(0)] is true if the alarm signal for the timer hasn't gone off yet.
       False otherwise to signal to the other part of the program the timeout.*)
    let curr_stat = [|true|] in

    (** [gameend] is the function that is the behavior the program shows when
        the alarm for the timer is signaled.*)
    let gameend x= 
      curr_stat.(0) <- false; in
    Sys.set_signal Sys.sigalrm (Sys.Signal_handle gameend);  

    (* Set the timer for 60 seconds *)
    let stat : Unix.interval_timer_status= {
      Unix.it_interval=0.0;
      Unix.it_value= 10.0
    } in 
    ignore(Unix.setitimer Unix.ITIMER_REAL stat);

    (**[gameon known] is the recursive function that asks for input and keeps 
       track of the correctly guessed buildings in [known] and updates the current 
       score  accordingly.  *)
    let rec gameon known =
      if (curr_stat.(0) =false) then begin
        print_endline "The game is over, timeout";
        let score = (curr_score.(0)) in 
        curr_score.(0) <- 0;
        score end
      else
        begin
          begin try
              let hall = String.lowercase_ascii (read_line()) in
              if (Array.mem hall dir) && (Array.mem hall known = false)
              then
                begin 
                  known.(Array.(curr_score.(0))) <- hall;
                  curr_score.(0) <- curr_score.(0) + 1; 
                  print_newline();
                  print_endline "Current score: "; 
                  print_int curr_score.(0);
                  print_newline();
                  gameon known
                end
              else begin 
                if (Array.mem hall known = true) then 
                  (print_endline "You already guessed this."; gameon known) 
                else 
                  (print_endline "This is not a correct answer."; gameon known) 
              end
            with
            | Invalid_argument _ -> print_endline "Please write a valid argument";
              gameon known
          end
        end
    in 
    gameon (Array.make len "00")
end
