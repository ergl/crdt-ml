open Mutable_types

module Make (O : Comparable) = struct
  module ISet = Set.Make (struct
    type t = (int * O.t)
    let compare (a, b) (c, d) = let tmp = compare a c in
      if tmp <> 0 then tmp else O.compare b d
  end)

  let _ = Random.self_init ()

  type t = (ISet.t * ISet.t) ref
  type elt = O.t

  let unique () = Random.bits ()

  let make () = let d = ISet.empty in ref (d, d)

  let add s el =
    let (a, r) = !s in
    s := (ISet.add (unique (), el) a, r)

  let value s =
    let (a, r) = !s in
    ISet.diff a r |> ISet.elements
    |> List.map snd
    |> List.sort_uniq O.compare

  let lookup s el =
    let (a, r) = !s in
    ISet.diff a r
    |> ISet.exists (fun (_, el') -> el = el')

  let remove s el =
    if lookup s el then begin
      let (a, r) = !s in
      let in_a = ISet.filter (fun (_, el') -> el = el') a
      in
      s := (a, ISet.union in_a r)
    end

  let merge s s' =
    let (a, r) = !s and
        (a', r') = !s'
    in
    s := (ISet.union a a', ISet.union r r')
end
