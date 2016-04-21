open Immutable_types

module Make (O : Comparable) = struct
  module ISet = Set.Make (struct
    type t = (int * O.t)
    let compare (a, b) (c, d) = let tmp = compare a c in
      if tmp <> 0 then tmp else O.compare b d
  end)

  let _ = Random.self_init ()

  type t = (ISet.t * ISet.t)
  type elt = O.t

  let unique () = Random.bits ()

  let make () = let d = ISet.empty in (d, d)

  let add el (a, r) =
    (ISet.add (unique (), el) a, r)

  let value (a, r) = ISet.diff a r
    |> ISet.elements
    |> List.map snd
    |> List.sort_uniq O.compare

  let lookup el (a, r) = ISet.diff a r
    |> ISet.exists (fun (_, el') -> el = el')

  let remove el s =
    if lookup el s then begin
      let (a, r) = s in
      let in_a = ISet.filter (fun (_, el') -> el = el') a in
      (a, ISet.union in_a r)
    end else s

  let merge (a, r) (a', r') =
    (ISet.union a a', ISet.union r r')

end
