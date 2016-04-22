open Immutable_types

(*$inject
  module StrGSet = I_GSet.Make(struct type t = string let compare = compare end)
*)

module Make (O : Comparable) = struct (*$< StrGSet *)
  module ISet = Set.Make (O)

  type t = ISet.t
  type elt = O.t
  
  let make () = ISet.empty

  let value = ISet.elements

  (*$QR add
    (* Adds monotonically advance upwards
       TODO: Create an I_GSet generator *)
    Q.string (fun s ->
      let a = make () in
      value a <= value @@ add s a
    )
  *)
  let add = ISet.add

  (*$QR lookup
      (* Lookup of s in add s always returns true *)
      Q.string (fun s ->
        let a = make () in
        lookup s (add s a) = true
      )
  *)
  let lookup = ISet.mem

  (*$QR merge
    Q.unit (fun () ->
      let a = make () and
          b = make () and
          c = make ()
      in
      ((merge a b |> value) = (merge b a |> value)) &&
      ((merge a a |> value) = (value a)) &&
      ((merge a (merge b c) |> value) = (merge (merge a b) c |> value)))
  *)
  let merge = ISet.union
end (*$>*)
