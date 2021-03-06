open Immutable_types

(*$inject
  module StrORSet = I_ORSet.Make(struct type t = string let compare = compare end)

  let small t = List.length (StrORSet.value t)

  let print t =
    let v = StrORSet.value t in
    if List.length v = 0 then "empty_orset"
    else String.concat " " v

  let gen : StrORSet.t QCheck.Gen.t = fun r -> StrORSet.make ()
  let orset : StrORSet.t QCheck.arbitrary = QCheck.make ~small ~print gen
*)

module Make (O : Comparable) = struct (*$< StrORSet *)
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

  (*$QR add
    (* Adds monotonically advance upwards *)
    Q.(pair string orset) (fun (s, a) ->
      value a <= value @@ add s a
    )
  *)
  let add el (a, r) =
    (ISet.add (unique (), el) a, r)

  let value (a, r) = ISet.diff a r
    |> ISet.elements
    |> List.map snd
    |> List.sort_uniq O.compare

  (*$QR lookup
    (* Lookup of s in add s always returns true *)
    Q.(pair string orset) (fun (s, a) ->
      lookup s (add s a) = true
    )
  *)
  let lookup el (a, r) = ISet.diff a r
    |> ISet.exists (fun (_, el') -> el = el')

  (*$QR remove
    (* Removes monotonically advance downwards *)
    Q.(pair string orset) (fun (s, a) ->
      value (add s a) >= value (remove s a)
    )
  *)
  let remove el s =
    if lookup el s then begin
      let (a, r) = s in
      let in_a = ISet.filter (fun (_, el') -> el = el') a in
      (a, ISet.union in_a r)
    end else s

  (*$QR merge
    Q.(triple orset orset orset) (fun (a, b, c) ->
      (merge a b |> value) = (merge b a |> value) &&
      (merge a a |> value) = (value a) &&
      (merge a (merge b c) |> value) = (merge (merge a b) c |> value))
  *)
  let merge (a, r) (a', r') =
    (ISet.union a a', ISet.union r r')

end (*$>*)
