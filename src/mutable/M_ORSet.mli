open Mutable_types

module Make (O : Comparable) : RSet with type elt = O.t