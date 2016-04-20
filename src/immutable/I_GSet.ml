open Immutable_types

module Make (O : Comparable) = struct
  module ISet = Set.Make (O)

  type t = ISet.t
  type elt = O.t
  
  let make () = ISet.empty

  let value = ISet.elements

  let add s el = ISet.add el s

  let lookup s el = ISet.mem el s

  let merge = ISet.union
end
