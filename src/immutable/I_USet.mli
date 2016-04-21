(** Add-once and remove-once set.

    {b Note}: Removed elements can never be added again. This is because of how
    [USet] handles the [value] operation (see below).

    Supports [add], [remove], [lookup] and [merge] operations.
    See {!module:Immutable_types.RSet}. Contains two separate instances of
    a regular [Map], one for adding ([add_s]) and the other for removing
    ([remove_s]).

    [add el t] adds [el] to [add_s].

    [remove el t] adds [el] to [remove_s]

    Both [lookup] and [value] operate on the set difference [add_s \ remove_s].

    [merge a b] calls merges [add_s_a] with [add_s_b] and the same for [b] *)

(** Creates an add / remove set of elements satisfying
    {!module:Immutable_types.Comparable}*)
module Make (O : Immutable_types.Comparable) : Immutable_types.RSet with
  type elt = O.t
