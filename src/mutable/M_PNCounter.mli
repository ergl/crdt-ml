(** Increment / decrement counters.

    Contains two separate instances of {!module:M_IntVector}, one for
    incrementing ([add_c]) and the other for decrementing ([remove_c]).

    The only difference between [PNCounter] and [GCounter] is that
    {!val:Mutable_types.IVector.query} [t] in the former returns the difference
    between the [add_c] and the [remove_c] vectors. *)

(** An Increment / decrement counter is a {!module:Mutable_types.IVector}
    with type [elt = int]*)
include Mutable_types.DCounter with type elt = int
