type elt = int
type payload = (int list * int list)
type t = (elt * payload)

let make_in_range modulo =
  let _ = Random.self_init () in
  let numsite = Random.int modulo in
  let payload = Array.(make (numsite + 1) 0 |> to_list) in
  (numsite, (payload, payload))

let make () = make_in_range 11

let query (_, (a, r)) =
  IList.fill_fold_left2 (fun acc a r -> acc + (a - r)) 0 a r

(*$QR incr; decr
  (* Combinations of incr and decr form a noop *)
  Q.unit (fun () ->
    let a = make () in
    (decr a |> incr |> query) = (incr a |> decr |> query) &&
    (incr a |> decr |> query) = query a
  )
*)

(*$QR incr
  (* Increments monotonically advance upwards
     TODO: Create an I_PNCounter generator *)
  Q.unit (fun () ->
    let a = make () in
    query a <= query @@ incr a
  )
*)
let incr (id, (a, r)) =
  (id, (IList.incr_nth a id, r))

(*$QR decr
  (* Decrements monotonically advance downwards
     TODO: Create an I_PNCounter generator *)
  Q.unit (fun () ->
    let a = make () in
    query a >= query @@ decr a
  )
*)
let decr (id, (a, r)) =
  (id, (a, IList.incr_nth r id))

(*$QR merge
  (* PNCounter.merge is commutative, idempotent and associative
     TODO: Create an I_PNCounter generator *)
  Q.unit (fun () ->
    let a = make () and
        b = make () and
        c = make ()
    in
    ((merge a b |> query) = (merge b a |> query)) &&
    ((merge a a |> query) = (query a)) &&
    ((merge a (merge b c) |> query) = (merge (merge a b) c |> query)))
*)
let merge (id, (a, r)) (_, (a', r')) =
  let max' a b = IList.fill_map2 max a b in
  (id, (max' a a', max' r r'))
