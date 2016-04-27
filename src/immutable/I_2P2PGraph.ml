module Make (O : Immutable_types.Comparable) = struct
  type vertex = O.t
  type edge = vertex * vertex
  
  module VxORSet = I_ORSet.Make (O)
  
  module EdORset = I_ORSet.Make (struct
    type t = edge
    let compare (v, u) (v', u') =
      let rs = O.compare v v' in
      if rs <> 0 then rs
      else O.compare u u'
    end)

  type t =
  { vertices : VxORSet.t
  ; edges : EdORset.t
  }

  let make () =
  { vertices = VxORSet.make ()
  ; edges = EdORset.make ()
  }

  let lookup_v v g = VxORSet.lookup v g.vertices
  let lookup_e (v1, v2) g =
    lookup_v v1 g &&
    lookup_v v2 g &&
    EdORset.lookup (v1, v2) g.edges

  let add_vertex v g =
    { g with vertices = VxORSet.add v g.vertices }

  let add_edge (v, u) g =
    if (lookup_v v g) && (lookup_v u g)
      then { g with edges = EdORset.add (v, u) g.edges }
    else g

  let remove_vertex w g =
    let is_in = lookup_v w g and
        not_in_edges = EdORset.value g.edges
        |> List.for_all (fun (u, v) -> u != w && v != w)
    in
    if is_in && not_in_edges then
       { g with vertices = VxORSet.remove w g.vertices }
    else g

  let remove_edge e g =
    if lookup_e e g then
      { g with edges = EdORset.remove e g.edges }
    else g

  let merge {vertices = vs; edges = es} {vertices = vs'; edges = es'} =
    { vertices = VxORSet.merge vs vs'
    ; edges = EdORset.merge es es'
    }
end
