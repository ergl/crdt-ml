(** Increment-only counters.

    Conceptually the same as a {!module:I_IntVector}. The only difference is
    that {!val:Immutable_types.IVector.query} [t] returns the sum of all the
    elements in the vector. *)

(** An Increment-only counter is a {!module:Immutable_types.IVector} with type
    [elt = int]*)
include Immutable_types.IVector with type elt = int
