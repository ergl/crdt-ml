(** Increment-only counters.

    Conceptually the same as a {!module:M_IntVector}. The only difference is
    that {!val:Mutable_types.IVector.query} [t] returns the sum of all the
    elements in the vector. *)

(** An Increment-only counter is a {!module:Mutable_types.IVector} with type
    [elt = int]*)
include Mutable_types.IVector with type elt = int
