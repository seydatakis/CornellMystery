
type room_style = 
  |Start
  |Chance
  |Regular
  |Store

type item_name = string
type item_points = int
type item = (item_name * item_points)
type journal = string list

let init_mystery=
  [|
    Start; Regular;
    Regular; Regular;
    Chance; Store;
    Regular; Regular;
    Chance; Regular;
    Regular; Regular;
    Chance; Regular;
    Store; Regular
  |]

let suspect_list = [|"Chimesmaster"; "Happy Dave"; "Grees"; "Floster"|]

let weapon_list = [|"Push"; "Poison"; "Banana Peel"; "iClicker"|]

let question_list = ["Where were you at the time of the event? (-10pts)"; 
                     "What were you doing? (-20pts)"; 
                     "Who were you with? (-30pts)"; 
                     "Did you see anything? (-40pts)"; 
                     "What do you know about the student? (-50pts)"]

let chimesmaster = [|
  "I was at the super popular breakfast party at Okenshields."; 
  "I was eating and talking with people. The student was there too.";
  "I was with a lot of different people."; 
  "I didn't really see anything."; 
  "The student was a very good musician. He applied many times to be a chimemaster."|]

let dave = [|
  "I was at the super popular breakfast party"; 
  "I was manning the swipe in station at the entrance."; 
  "A lot of students and faculty came to our super popular breakfast party.";
  "I didn't see anything out of the ordinary.";
  "The student was a great person, one who will never be forgotten."|]

let grees = [|
  "I was in the parking lot behind Willard Straight Hall.";
  "I was heading to my car to drive to Wegmans."; 
  "I was by myself."; 
  "I saw Foster in his car in the same parking lot."; 
  "The student might have been in one of my classes."|]

let floster = [|
  "I was in my office."; 
  "I was creating the preliminary exam for CS 3110."; 
  "I was alone."; 
  "I did not see anything in particular."; 
  "I believe that the student was enrolled in CS 3110."|]

let get_type (room_num:int) = 
  init_mystery.(room_num)

let items_list = [
  ("binoculars", 10);
  ("tape recorder", 20);
  ("spy camera", 30);
  ("night vision goggles", 40);
  ("fingerprint testing kit", 50);
  ("lie detector", 60);
  ("journal", 70)
]

(** [start] represents the visual layout of the board at the starting position*)
let start =
  "
————————————————————————————————————————————————————————
|   HERE   |          |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [one] represents the visual layout of the board at the first square*)
let one =  
  "
————————————————————————————————————————————————————————
|          |   HERE   |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [two] represents the visual layout of the board at the second square*)
let two = 
  "
————————————————————————————————————————————————————————
|          |          |   HERE   |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [three] represents the visual layout of the board at the third square*)
let three = 
  "
————————————————————————————————————————————————————————
|          |          |          |   HERE   |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————��———————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [four] represents the visual layout of the board at the fourth square*)
let four = 
  "
————————————————————————————————————————————————————————
|          |          |          |          |   HERE   |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [five] represents the visual layout of the board at the fifth square*)
let five = 
  "
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |   HERE   |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [six] represents the visual layout of the board at the sixth square*)
let six = 
  "
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |   HERE   |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [seven] represents the visual layout of the board at the seventh square*)
let seven = 
  "
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |   HERE   |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [eight] represents the visual layout of the board at the eighth square*)
let eight = 
  "
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |          |   HERE   |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [nine] represents the visual layout of the board at the ninth square*)
let nine = 
  "
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |   HERE   |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [ten] represents the visual layout of the board at the tenth square*)
let ten = 
  "
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |   HERE   |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [eleven] represents the visual layout of the board at the eleventh square*)
let eleven = 
  "
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |   HERE   |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [twelve] represents the visual layout of the board at the twelfth square*)
let twelve = 
  "
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|   HERE   |          |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [thirteen] represents the visual layout of the board at the thirteenth square*)
let thirteen = 
  "
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|   HERE   |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [fourteen] represents the visual layout of the board at the fourteenth square*)
let fourteen = 
  "
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|   HERE   |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

(** [fifteen] represents the visual layout of the board at the fifteenth square*)
let fifteen = 
  "
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|    go    |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
|   HERE   |                                |          |
|          |                                |          |
|   plot   |                                |  store   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|  store   |                                |   plot   |
———————————-                                ————————————
|          |                                |          |
|          |                                |          |
|   plot   |                                |   plot   |
————————————————————————————————————————————————————————
|          |          |          |          |          |
|          |          |          |          |          |
|  chance  |   plot   |   plot   |   plot   |  chance  |
————————————————————————————————————————————————————————
"

let board_map = [start; one; two; three; four; five; six; seven;
                 eight; nine; ten; eleven; twelve; thirteen; fourteen; fifteen]

let rec display_board num acc map = 
  match map with
  |[] -> failwith "will not enter here"
  |h::t -> 
    if num = acc then h 
    else display_board num (acc+1) t


