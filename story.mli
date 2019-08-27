(** All code in this mli file, and its corresponding ml file, is adapated from 
    the CS 3110 textbook online. *)

(** Module representation of each plot point in the storyline of the game, 
    including functions that update the storyline. *)

(** Raised when a mutable stack representing the abstract type Story is empty. *)
exception Empty

(** A mutable stack is used to abstract the representation of a Story. *)

(* ['a t] is the type of stack whose elements have type ['a]. The stack 
     abstracts the type *)

(* A [node] is a node of a mutable linked list.  It has
  * a field [value] that contains the node's value, and
  * a mutable field [next] that is [Null] if the node has
 * no successor, or [Some n] if the successor is [n]. *)  
type node

(* AF: A [t] is a stack represented by a mutable linked list.
  * The mutable field [top] is the first node of the list,
  * which is the top of the stack. The empty stack is represented
  * by {top = None}.  The node {top = Some n} represents the
  * stack whose top is [n], and whose remaining elements are
  * the successors of [n]. *)
type t

(** [empty ()] is an empty Story. *)
val empty : unit -> t

(* [peek s] is the top element of [s].
 * raises: [Empty] if [s] is empty. *)
val peek : t -> string

(* [pop s] removes the top element of a Story [s].
 * raises: [Empty] if [s] is empty.
   To pop [s], we mutate the top of the stack to become its successor. *)
val pop : t -> unit

(* [push x s] modifies a Story [s] to make [x] its top element.
 * The rest of the elements are unchanged.
   To push [x] onto [s], we allocate a new node with [Some {...}].
 * Its successor is the old top of the stack, [s.top].
 * The top of the stack is mutated to be the new node. *)
val push : string -> t -> unit

(** [get_story file_hdl acc] takes the story from the [file_hdl] text file and
    puts it into one string *)
val get_story : in_channel -> string -> string

(** [init_story] creates the story corresponding to the mystery storyboard.*)
val init_story : t 

