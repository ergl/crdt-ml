type t
type elt = string

val make : unit -> t

val value : t -> elt list

val add : t -> elt -> unit

val remove : t -> elt -> unit

val merge : t -> t -> unit
