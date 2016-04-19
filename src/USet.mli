module type OrderedType = sig
  type t
  val compare : t -> t -> int
end

module type S = sig
  type t
  type elt
  val make : unit -> t
  val value : t -> elt list
  val add : t -> elt -> unit
  val remove : t -> elt -> unit
  val merge : t -> t -> unit
end

module Make (O : OrderedType) : S with type elt = O.t
