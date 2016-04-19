type t
type state = int list

val make_of_size : int -> t
val make_with : state -> t

val query : t -> state

val update : int -> t -> unit

val merge : t -> t -> unit
