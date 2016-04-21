open Mutable_types

module Make (O : Comparable) = struct
  module ISet = Set.Make (O)
  
  type t = (ISet.t * ISet.t) ref
  type elt = O.t

  let make () = let d = ISet.empty in ref (d, d)

  let value s =
    let (a, r) = !s in
    ISet.elements @@ ISet.diff a r

  let add el s =
    let (a, r) = !s in
    s := (ISet.add el a, r)

  let lookup el s =
    let (a, r) = !s in
    ISet.mem el @@ ISet.diff a r

  let remove el s =
    if lookup el s then begin
      let (a, r) = !s in
      s := (a, ISet.add el r)
    end

  let merge s s' =
    let (a, r) = !s and
        (a', r') = !s'
    in
    s := (ISet.union a a', ISet.union r r')
    
end
