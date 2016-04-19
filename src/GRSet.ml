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
  val merge : t -> t -> unit
end

module Make (O : OrderedType) = struct
  module ISet = Set.Make (O)

  type t = ISet.t ref
  type elt = O.t
  

  let make () = ref ISet.empty

  let value s = ISet.elements !s

  let add s el = s := ISet.add el !s

  let merge s s' = s := ISet.union !s !s'
end
