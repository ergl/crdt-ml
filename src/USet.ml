module ISet = Set.Make (struct
  type t = string
  let compare = compare
end)

type elt = string
type t = (ISet.t * ISet.t) ref

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
