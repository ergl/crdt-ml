open Mutable_types

module Make (O : Comparable) = struct
  module ISet = Set.Make (O)

  type t = ISet.t ref
  type elt = O.t
  
  let make () = ref ISet.empty

  let value s = ISet.elements !s

  let add el s = s := ISet.add el !s

  let lookup el s = ISet.mem el !s

  let merge s s' = s := ISet.union !s !s'
end
