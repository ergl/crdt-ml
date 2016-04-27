(** Simple Graph CRDT.

    Implemented as four OR-Sets for vertices and edges. *)

module Make (O : Immutable_types.Comparable) : Immutable_types.Graph with
  type vertex = O.t
