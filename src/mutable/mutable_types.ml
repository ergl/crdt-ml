(** This module contains all mutable CRDT types, as well as some type
    properties that CRDT state must satisfy. *)


(** Comparable types. All elements in a set must satisfy this property.

    Same as the built-in [Set.OrderedType], this type includes a [t] and a
    [compare : t -> t -> int] function. See [Pervasives.compare] *)
module type Comparable = sig
  include Set.OrderedType
end


(** Mergeable types. All CRDTs satisfy this property. *)
module type Mergeable = sig

  (** Type of mergeable elements. *)
  type t

  (** Create a new mergeable element. *)
  val make : unit -> t

  (** [merge a b] will merge the state of [b] with the one from [a].
      Updates [a]. *)
  val merge : t -> t -> unit
end


(** Vector Clock and increment-only counter types. Supports merging and
    incrementing. The [elt] type must be supplied when including. *)
module type IVector = sig
  include Mergeable

  (** Type of the contents of an [IVector] *)
  type elt

  (** [make_in_range n] creates a new [IVector] of size ranging from [0] to [n].
      being [n] greater than 0 and smaller than 2^30.

      When merging two CRDTs of different sizes, the smaller one grows and pads
      the remaining space with zeros. *)
  val make_in_range : int -> t

  (** [query t] returns the raw state of [t] *)
  val query : t -> elt

  (** [incr t] increments the position associated with the [numsite] of [t].
      See {!module:M_IntVector} for more information on [numsites]. *)
  val incr : t -> unit
end


(** Increment / decrement counter type. Supports merging, incrementing and
    decrementing.

    The [elt] type (included from [IVector] must be supplied when including). *)
module type DCounter = sig
  include IVector

  (** [decr t] decrements the position associated with the [numsite] of [t].
      See {!module:M_IntVector} for more information on [numsites]. *)
  val decr : t -> unit
end


(** Grow-Only set type. Supports merging, adding and lookup operations. *)
module type GSet = sig
  include Mergeable

  (** Type of the contents of [GSet] *)
  type elt

  (** [add el t] adds [el] in-place to [t]. *)
  val add : elt -> t -> unit

  (** [value t] gets the raw state of [t]. *)
  val value : t -> elt list

  (** [lookup el t] returns true if [el] is in [t]. *)
  val lookup : elt -> t -> bool
end


(** Add and remove set type. Supports merging, adding and lookup operations. *)
module type RSet = sig
  include GSet

  (** [remove el t] removes [el] from [t] only if [el] is in [t].
      Does nothing otherwise. *)
  val remove : elt -> t -> unit
end
