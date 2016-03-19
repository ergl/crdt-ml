open Types
open Util

module Vector : IntVector = struct
  type state = int list
  type t = state ref
  let make () = ref [0]
  let make_with state = ref state
  let query v = !v
  let update pos t = t := IList.incr_nth !t pos
  let merge v v' = v := IList.map2 max !v !v'
end

module Counter : Counter = struct
  type state = int list
  type t = state ref
  let make () = ref [0]
  let make_with state = ref state
  let query v = List.fold_left (+) 0 !v
  let update pos t = t := IList.incr_nth !t pos
  let merge v v' = v := IList.map2 max !v !v'
end

module DCounter : DCounter = struct
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
end

module GRSet : GRSet = struct
  module ISet = Set.Make (struct
    type t = string
    let compare = compare
  end)

  type elt = string
  type t = ISet.t ref

  let make () = ref ISet.empty
  let value s = ISet.elements !s
  let add s el = s := ISet.add el !s
  let merge s s' = s := ISet.union !s !s'
end

module USet : USet = struct
  module ISet = Set.Make (struct
    type t = string
    let compare = compare
  end)

  type elt = string
  type t = (ISet.t * ISet.t) ref

  let make () = let d = ISet.empty in ref (d, d)
  let value s =
    let (a, r) = !s in
    ISet.elements @@ ISet.diff a r

  let add s el =
    let (a, r) = !s in
    s := (ISet.add el a, r)

  let remove s el =
    let (a, r) = !s in
    s := (a, ISet.add el r)

  let merge s s' =
    let (a, r) = !s and
        (a', r') = !s'
    in
    s := (ISet.union a a', ISet.union r r')
end
