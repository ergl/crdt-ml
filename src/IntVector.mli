type t

val make : unit -> t
val make_in_range : int -> t

val query : t -> int list

val update : t -> unit

val merge : t -> t -> unit
