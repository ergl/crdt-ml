(** Observed-Remove set.

    Supports [add], [remove], [lookup] and [merge] operations.
    See {!module:Immutable_types.RSet}. Contains two separate instances of
    a regular [Map], one for adding ([add_s]) and the other for removing
    ([remove_s]).

    [add el t] adds [(unique (), el)] to [add_s], where unique is the result of
    calling
    {{:http://caml.inria.fr/pub/docs/manual-ocaml/libref/Random.html#VALbits}
    Random.bits}. This may or may not be enough entropy for your use case.

    [remove el t] adds all [{(u, el) | ∃ u : (u, el) ∈ add_s}] to [remove_s]

    Both [lookup] and [value] operate on the set difference [add_s \ remove_s].

    [merge a b] calls merges [add_s_a] with [add_s_b] and the same for [b] *)

(** Creates an add / remove set of elements satisfying
    {!modtype:Immutable_types.Comparable}*)
module Make (O : Immutable_types.Comparable) : Immutable_types.RSet with
  type elt = O.t
