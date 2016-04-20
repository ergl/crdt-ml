open Mutable_types

type elt = int
type t = (elt * int list) ref

let make_in_range modulo =
  let _ = Random.self_init () in
  let numsite = Random.int modulo in
  ref (numsite, Array.(make (numsite + 1) 0 |> to_list))

let make () = make_in_range 11

let query v = List.fold_left (+) 0 (snd !v)

let incr v =
  let id = fst !v in
  v := (id, IList.incr_nth (snd !v) id)

let merge v v' =
  let (id, state) = !v and
      (_, state') = !v'
  in
  v := (id, IList.fill_map2 max state state')
