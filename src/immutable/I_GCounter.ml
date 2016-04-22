(*$inject
  let small = I_GCounter.query
  let gen : I_GCounter.t QCheck.Gen.t = fun r -> I_GCounter.make ()
  let gctr : I_GCounter.t QCheck.arbitrary = QCheck.make ~small gen
*)

type elt = int
type t = (elt * int list)

let make_in_range modulo =
  let _ = Random.self_init () in
  let numsite = Random.int modulo in
  (numsite, Array.(make (numsite + 1) 0 |> to_list))

let make () = make_in_range 11

let query (_, pl) = List.fold_left (+) 0 pl

(*$QR incr
  (* Updates monotonically advance upwards  *)
  gctr (fun a ->
    query a <= query (incr a)
  )
*)
let incr (id, payload) =
  (id, IList.incr_nth payload id)

(*$QR merge
  (* GCounter.merge is commutative, idempotent and associative  *)
  Q.(triple gctr gctr gctr) (fun (a, b, c) ->
    (merge a b |> query) = (merge b a |> query) &&
    (merge a a |> query) = (query a) &&
    (merge a (merge b c) |> query) = (merge (merge a b) c |> query))
*)
let merge (id, pl) (_, pl') =
  (id, IList.fill_map2 max pl pl')
