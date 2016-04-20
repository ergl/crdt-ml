open Immutable_types

type elt = int
type t = (elt * int list)

let make_in_range modulo =
  let _ = Random.self_init () in
  let numsite = Random.int modulo in
  (numsite, Array.(make (numsite + 1) 0 |> to_list))

let make () = make_in_range 11

let query (_, pl) = List.fold_left (+) 0 pl

let incr (id, payload) =
  (id, IList.incr_nth payload id)

let merge (id, pl) (_, pl') =
  (id, IList.fill_map2 max pl pl')
