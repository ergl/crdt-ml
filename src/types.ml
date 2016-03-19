module type IntVector = sig
  type t
  type state = int list
  val make : unit -> t
  val make_with : state -> t
  val query : t -> state
  val update : int -> t -> unit
  val merge : t -> t -> unit
end

module type Counter = sig
  type t
  type state = int list
  val make : unit -> t
  val make_with : state -> t
  val query : t -> int
  val update : int -> t -> unit
  val merge : t -> t -> unit
end

module type DCounter = sig
  type t
  type state = int list
  val make : unit -> t
  val make_with : state -> t
  val query : t -> int
  val incr : t -> unit
  val decr : t -> unit
  val incr_pos : int -> t -> unit
  val decr_pos : int -> t -> unit
  val merge : t -> t -> unit
end

module type GRSet = sig
    type t
    type elt = string
    val make : unit -> t
    val value : t -> elt list
    val add : t -> elt -> unit
    val merge : t -> t -> unit
end

module type USet = sig
  type t
  type elt = string
  val make : unit -> t
  val value : t -> elt list
  val add : t -> elt -> unit
  val remove : t -> elt -> unit
  val merge : t -> t -> unit
end
