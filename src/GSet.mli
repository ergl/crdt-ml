module type OrderedType = sig
  type t
  val compare : t -> t -> int
end

module type S = sig
  type t
  type elt
  val make : unit -> t
  val add : t -> elt -> unit
  val value : t -> elt list
  val lookup : t -> elt -> bool
  val merge : t -> t -> unit
end

module Make (O : OrderedType) : S with type elt = O.t