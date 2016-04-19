module ISet = Set.Make (struct
  type t = string
  let compare = compare
end)

type elt = string
type t = ISet.t ref

let make () = ref ISet.empty

let value s = ISet.elements !s

let add s el = s := ISet.add el !s

let merge s s' = s := ISet.union !s !s'
