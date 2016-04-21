(** Grow-Only sets.

    Supports [add], [lookup] and [merge] operations.
    See {!module:Immutable_types.GSet} *)


(** Creates an grow-only set of elements satisfying
    {!module:Immutable_types.Comparable}*)
module Make (O : Immutable_types.Comparable) : Immutable_types.GSet with
  type elt = O.t
