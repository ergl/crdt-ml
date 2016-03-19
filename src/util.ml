module IList = struct
  include List
  let incr_nth: int list -> int -> int list = fun l pos ->
    List.mapi
      (fun ith el ->
        if ith = pos then el + 1 else el)
    l

  let rec fillz : int list -> int -> int list = fun l n ->
    if n = 0 then l
    else fillz (l @ [0]) (n - 1)

  let map2 f l l' =
    let la = List.length l and
        lb = List.length l' in
    let diff = abs @@ la - lb in
    if la = lb then List.map2 f l l'
    else if la > lb then List.map2 f l @@ fillz l' diff
    else List.map2 f (fillz l diff) l'

  let fold_left2 f acc l l' =
    let la = List.length l and
        lb = List.length l' in
    let diff = abs @@ la - lb in
    if la = lb then List.fold_left2 f acc l l'
    else if la > lb then List.fold_left2 f acc l @@ fillz l' diff
    else List.fold_left2 f acc (fillz l diff) l'

end
