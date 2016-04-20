type id = int
type t = (id * int list) ref

let make_in_range modulo =
  let _ = Random.self_init () in
  let numsite = Random.int modulo in
  ref (numsite, Array.(make (numsite + 1) 0 |> to_list))

let make () = make_in_range 11

let query v = (snd !v)

let update t =
  let id = fst !t in
  t := (id, IList.incr_nth (snd !t) id)

let merge v v' =
  let (id, state) = !v and
      (_, state') = !v'
  in
  v := (id, IList.map2 max state state')
