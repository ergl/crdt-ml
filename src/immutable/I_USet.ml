open Immutable_types

(*$inject
  module StrUSet = I_USet.Make(struct type t = string let compare = compare end)

  let small t = List.length (StrUSet.value t)

  let print t =
    let v = StrUSet.value t in
    if List.length v = 0 then "empty_uset"
    else String.concat " " v

  let gen : StrUSet.t QCheck.Gen.t = fun r -> StrUSet.make ()
  let uset : StrUSet.t QCheck.arbitrary = QCheck.make ~small ~print gen
*)

module Make (O : Comparable) = struct (*$< StrUSet *)
  module ISet = Set.Make (O)
  
  type t = (ISet.t * ISet.t)
  type elt = O.t

  let make () = let d = ISet.empty in (d, d)

  let value (a, r) = ISet.diff a r
    |> ISet.elements

  (*$QR add
    (* Adds monotonically advance upwards *)
    Q.(pair string uset) (fun (s, a) ->
      value a <= value (add s a)
    )
  *)
  let add el (a, r) = (ISet.add el a, r)

  (*$QR lookup
    (* Lookup of s in add s always returns true *)
    Q.(pair string uset) (fun (s, a) ->
      lookup s (add s a) = true
    )
  *)
  let lookup el (a, r) = ISet.diff a r
    |> ISet.mem el

  (*$QR remove
    (* Removes monotonically advance downwards *)
    Q.(pair string uset) (fun (s, a) ->
      value (add s a) >= value (remove s a)
    )
  *)
  let remove el s =
    if lookup el s then begin
      let (a, r) = s in
      (a, ISet.add el r)
    end else s

  (*$QR merge
    Q.(triple uset uset uset) (fun (a, b, c) ->
      (merge a b |> value) = (merge b a |> value) &&
      (merge a a |> value) = (value a) &&
      (merge a (merge b c) |> value) = (merge (merge a b) c |> value))
  *)
  let merge (a, r) (a', r') =
    (ISet.union a a', ISet.union r r')
    
end (*$>*)
