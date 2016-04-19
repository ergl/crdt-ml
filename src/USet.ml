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

module Make (O : OrderedType) = struct
  module ISet = Set.Make (O)
  
  type t = (ISet.t * ISet.t) ref
  type elt = O.t

  let make () = let d = ISet.empty in ref (d, d)

  let value s =
    let (a, r) = !s in
    ISet.elements @@ ISet.diff a r

  let add s el =
    let (a, r) = !s in
    s := (ISet.add el a, r)

  let remove s el =
    let (a, r) = !s in
    s := (a, ISet.add el r)

  let merge s s' =
    let (a, r) = !s and
        (a', r') = !s'
    in
    s := (ISet.union a a', ISet.union r r')
    
end
