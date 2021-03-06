(*$inject
  let gen : I_IntVector.t QCheck.Gen.t = fun r -> I_IntVector.make ()
  let ivt : I_IntVector.t QCheck.arbitrary = QCheck.make gen
*)

type id = int
type elt = int list
type t = (id * elt)

(*$QR make_in_range
  Q.(int_range 1 10000) (fun i ->
    let size = make_in_range i |> query |> List.length
    in
    size > 0 && size <= i
  )
*)
let make_in_range modulo =
  let _ = Random.self_init () in
  let numsite = Random.int modulo in
  (numsite, Array.(make (numsite + 1) 0 |> to_list))

(*$QR make
  Q.unit (fun () ->
    let size = make () |> query |> List.length in
    size > 0 && size <= 11)
*)
let make () = make_in_range 11

let query = snd

(*$QR incr
  (* Updates monotonically advance upwards *)
  ivt (fun a ->
    query a <= query (incr a)
  )
*)
let incr (id, payload) =
  (id, IList.incr_nth payload id)

(*$QR merge
  (* IntVector.merge is commutative, idempotent and associative *)
  Q.(triple ivt ivt ivt) (fun (a, b, c) ->
    (merge a b |> query) = (merge b a |> query) &&
    (merge a a |> query) = (query a) &&
    (merge a (merge b c) |> query) = (merge (merge a b) c |> query))
*)
let merge (id, payload) (_, payload') =
  (id, IList.fill_map2 max payload payload')
