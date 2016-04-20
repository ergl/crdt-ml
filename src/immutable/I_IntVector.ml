type id = int
type elt = int list
type t = (id * elt)

let make_in_range modulo =
  let _ = Random.self_init () in
  let numsite = Random.int modulo in
  (numsite, Array.(make (numsite + 1) 0 |> to_list))

let make () = make_in_range 11

let query = snd

let incr (id, payload) =
  (id, IList.incr_nth payload id)

let merge (id, payload) (_, payload') =
  (id, IList.fill_map2 max payload payload')

