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

let incr (id, (a, r)) =
  (id, (IList.incr_nth a id, r))

let decr (id, (a, r)) =
  (id, (a, IList.incr_nth r id))

let merge (id, (a, r)) (_, (a', r')) =
  let max' a b = IList.fill_map2 max a b in
  (id, (max' a a', max' r r'))
