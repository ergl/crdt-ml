(** Grow-Only sets.

    Supports [add], [lookup] and [merge] operations.
    See {!module:Mutable_types.GSet} *)


(** Creates an grow-only set of elements satisfying
    {!module:Mutable_types.Comparable}*)
module Make (O : Mutable_types.Comparable) : Mutable_types.GSet with
  type elt = O.t
