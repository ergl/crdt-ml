(** Vector Clocks.

    An integer vector where each replica is restricted to incrementing its own
    index [i]. This index is generated at random and assigned to a [numsite]
    value when calling [make ()] or [make_in_range n]. All subsequent calls to
    update operations will only act on the position noted by [numsite].

    By default, {!val:Mutable_types.Mergeable.make} just calls
    {!val:Mutable_types.IVector.make_in_range} [n] with [n = 11]. You can
    override this by calling [make_in_range] directly. *)

(** A Vector Clock is a {!module:Mutable_types.IVector} with type
    [elt = int list]*)
include Mutable_types.IVector with type elt = int list

