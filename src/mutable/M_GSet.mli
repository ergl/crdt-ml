open Mutable_types

module Make (O : Comparable) : GSet with type elt = O.t