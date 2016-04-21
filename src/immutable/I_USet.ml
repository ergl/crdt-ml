open Immutable_types

module Make (O : Comparable) = struct
  module ISet = Set.Make (O)
  
  type t = (ISet.t * ISet.t)
  type elt = O.t

  let make () = let d = ISet.empty in (d, d)

  let value (a, r) = ISet.diff a r
    |> ISet.elements

  let add el (a, r) = (ISet.add el a, r)

  let lookup el (a, r) = ISet.diff a r
    |> ISet.mem el

  let remove el s =
    if lookup el s then begin
      let (a, r) = s in
      (a, ISet.add el r)
    end else s

  let merge (a, r) (a', r') =
    (ISet.union a a', ISet.union r r')
    
end
