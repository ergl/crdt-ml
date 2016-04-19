type state = int list
type t = (state * state) ref

let make () = let d = [0] in ref (d,d)
let make_with state = ref (state, state)

let query v =
  let (a, r) = !v in
  IList.fold_left2 (fun acc a r -> acc + (a - r)) 0 a r

let incr_pos pos v =
  let (a, r) = !v in
  v := (IList.incr_nth a pos, r)

let decr_pos pos v =
  let (a, r) = !v in
  v := (a, IList.incr_nth r pos)

let incr v = incr_pos 0 v
let decr v = decr_pos 0 v

let merge v v' =
  let (a, r) = !v and
      (a', r') = !v' and
      max' a b = IList.map2 max a b
  in
  v := (max' a a', max' r r')
  