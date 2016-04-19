type state = int list
type t = state ref

let make_of_size size = ref Array.(make size 0 |> to_list)
let make_with state = ref state

let query v = !v

let update pos t = t := IList.incr_nth !t pos

let merge v v' = v := IList.map2 max !v !v'
