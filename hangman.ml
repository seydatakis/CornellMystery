open ANSITerminal
open Minigame 

module Hangman : Mini = struct
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

  (** [make_word word guessed acc] is a string that
      has the letters of [word] that are not in [guessed] replaced with '_'. There 
      is a space between each character to make the word easily readable.*)
  let rec make_word (word:string) guessed (acc:string)=
    match word with
    | "" -> acc
    | x -> 
      let init= (String.get x 0) in
      if List.mem init guessed then
        let new_acc= String.concat "" [acc;(String.make 1 init)^" "] in
        make_word (String.sub word 1 ((String.length word)-1)) guessed new_acc

      else
        let new_acc= String.concat "" [acc;"_ "] in
        make_word (String.sub word 1 ((String.length word)-1)) guessed new_acc

  (**[gamoeon word guessed lives] is the helper function that runs the hangman 
     game by checking if the remainin[g lives] are more than zero and asking for a 
     char input to update [guessed] and display the current state of the word 
     that is being guessed.  *)
  let rec gameon  word guessed lives =
    if lives =0 then
      begin
        print_endline "You lost. The word was: ";
        print_endline word;
        0
      end
    else

      begin
        begin try
            let c =  Char.lowercase_ascii (String.get (read_line()) 0) in
            if (String.contains word c) then
              begin
                print_endline "You got this letter right!";
                let guessed = c::guessed in
                let curr_word = make_word word guessed "" in 
                print_endline curr_word;
                if (String.contains curr_word '_')== false then begin
                  print_endline "You won! You gained 20 points.";
                  20
                end
                else
                  begin
                    gameon word guessed lives 
                  end
              end
            else begin
              print_endline "This word doesn't contain this letter.";
              print_endline "Lives left: "; print_int (lives-1); print_newline();
              gameon word guessed (lives-1)
            end
          with 
          | Invalid_argument _ -> print_endline "Please enter a valid letter."; 
            gameon word guessed lives
        end
      end

  (** [game()] is the function that starts the minigame Hangman by choosing a 
      random word from the directory and calling [gameon]*)
  let game ()=
    let ranint =
      Random.self_init(); Random.int len in

    let word = dir.(ranint) in

    let wlength = String.length word in
    print_string [green] "Let's play hangman!";
    Pervasives.print_string " You have 5 lives, try to guess letters until you find the name of the building.\n
Enter only one letter at a time. If you enter more than one, the game will use the first letter you entered.\n" ;
    print_endline "Number of letters:"; print_int wlength;  print_newline();

    gameon word [] 5

end