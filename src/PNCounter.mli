type t
type state = int list

val make : unit -> t
val make_with : state -> t

val query : t -> int

val incr : t -> unit
val decr : t -> unit

val merge : t -> t -> unit
