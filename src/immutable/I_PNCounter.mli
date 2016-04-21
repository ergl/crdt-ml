(** Increment / decrement counters.

    Contains two separate instances of {!module:I_IntVector}, one for
    incrementing ([add_c]) and the other for decrementing ([remove_c]).

    The only difference between [PNCounter] and [GCounter] is that
    {!val:Immutable_types.IVector.query} [t] in the former returns the difference
    between the [add_c] and the [remove_c] vectors. *)

(** An Increment / decrement counter is a {!module:Immtable_types.IVector}
    with type [elt = int]*)
include Immutable_types.DCounter with type elt = int
