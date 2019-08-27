exception Empty

type node = {value : string; mutable next : node option}

type t = {mutable top : node option}


let empty () = 
  {top = None}


let push x s =
  s.top <- Some {value = x; next = s.top}


let peek s =
  match s.top with
  | None -> raise Empty
  | Some {value} -> value


let pop s =
  match s.top with
  | None -> raise Empty
  | Some {next} -> s.top <- next


(** [get_story file_hdl acc] takes the story from the [file_hdl] text file and
    puts it into one string *)
let rec get_story file_hdl acc=
  try  let new_line = Pervasives.input_line file_hdl in
    (get_story file_hdl acc^new_line) 
  with 
  | End_of_file -> 
    Pervasives.close_in file_hdl;
    print_endline acc;
    acc

(** [init_story] creates the story corresponding to the mystery storyboard.*)
let init_story =
  let file_path= (Unix.getcwd ())^Filename.dir_sep^"story_mystery.txt" in 
  let file_handle = Pervasives.open_in file_path in
  let whole_story = get_story file_handle "" in
  let story_string= String.split_on_char '/' whole_story in 
  let rec loop (story:string list) (acc: t) = 
    match story with
    |[] -> acc
    | h::t -> 
      push h acc;
      loop t acc
  in loop story_string (empty ())

