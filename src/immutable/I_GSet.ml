open Immutable_types

(*$inject
  module StrGSet = I_GSet.Make(struct type t = string let compare = compare end)

  let small t = List.length (StrGSet.value t)

  let print t =
    let v = StrGSet.value t in
    if List.length v = 0 then "empty_gset"
    else String.concat " " v

  let gen : StrGSet.t QCheck.Gen.t = fun r -> StrGSet.make ()
  let gset : StrGSet.t QCheck.arbitrary = QCheck.make ~small  ~print gen
*)

module Make (O : Comparable) = struct (*$< StrGSet *)
  module ISet = Set.Make (O)

  type t = ISet.t
  type elt = O.t
  
  let make () = ISet.empty

  let value = ISet.elements

  (*$QR add
    (* Adds monotonically advance upwards *)
    Q.(pair string gset) (fun (s, a) ->
      value a <= value (add s a)
    )
  *)
  let add = ISet.add

  (*$QR lookup
      (* Lookup of s in add s always returns true *)
      Q.(pair string gset) (fun (s, a) ->
        lookup s (add s a) = false
      )
  *)
  let lookup = ISet.mem

  (*$QR merge
    Q.(triple gset gset gset) (fun (a, b, c) ->
      (merge a b |> value) = (merge b a |> value) &&
      (merge a a |> value) = (value a) &&
      (merge a (merge b c) |> value) = (merge (merge a b) c |> value))
  *)
  let merge = ISet.union
end (*$>*)
