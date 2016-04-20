type elt = int
type payload = (int list * int list)
type t = (elt * payload) ref

let make_in_range modulo =
  let _ = Random.self_init () in
  let numsite = Random.int modulo in
  let payload = Array.(make (numsite + 1) 0 |> to_list) in
  ref (numsite, (payload, payload))

let make () = make_in_range 11

let query v =
  let (a, r) = snd !v in
  IList.fill_fold_left2 (fun acc a r -> acc + (a - r)) 0 a r

let incr v =
  let (id, pl) = !v in
  let (a, r) = pl in
  v := (id, (IList.incr_nth a id, r))

let decr v =
  let (id, pl) = !v in
  let (a, r) = pl in
  v := (id, (a, IList.incr_nth r id))

let merge v v' =
  let (id, pl) = !v and
      (_, pl') = !v'
  in
  let (a, r) = pl and
      (a', r') = pl' and
      max' a b = IList.fill_map2 max a b
  in
  v := (id, (max' a a', max' r r'))
