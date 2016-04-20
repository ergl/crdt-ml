(** Helper List library that supports dynamic padding for higher-order
    functions operating on lists of different length. *)

open List

(** [incr_nth l n] adds one to the [n]th element of l. *)
val incr_nth: int list -> int -> int list
  
(** [fill_map2 f l l'] padds with zeros the smaller list before applying [f]. *)
val fill_map2 : (int -> int -> int) -> int list -> int list -> int list

(** [fill_fold_left2 f l l'] padds with zeros the smaller list before applying [f]. *)
val fill_fold_left2 : (int -> int -> int -> int) -> int -> int list -> int list -> int
