module type Comparable = sig
  include Set.OrderedType
end

module type Mergeable = sig
  type t
  val make : unit -> t
  val merge : t -> t -> t
end

module type IVector = sig
  include Mergeable

  type elt
  val make_in_range : int -> t
  val query : t -> elt
  val incr : t -> t
end

module type DCounter = sig
  include IVector
  val decr : t -> t
end

module type GSet = sig
  include Mergeable

  type elt
  val add : t -> elt -> t
  val value : t -> elt list
  val lookup : t -> elt -> bool
end

module type RSet = sig
  include GSet
  val remove : t -> elt -> t
end
