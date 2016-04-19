type state = int list
type t = state ref

let make () = ref [0]
let make_with state = ref state

let query v = List.fold_left (+) 0 !v

let update pos t = t := IList.incr_nth !t pos
let incr v = update 0 v

let merge v v' = v := IList.map2 max !v !v'
