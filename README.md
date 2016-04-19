# CRDT - OCaml style

A CRDT (or Conflict-Free Replicated Data Type) is a data type designed to satisfy the Strong Eventual Consistency model.

In other words, given a set of replicas of the same data type, and a number of operations independently applied to any replica, all replicas will eventually reach the same state, no matter the order of the operations. These properties make CRDTs extremely useful for distributed KV stores and collaborative applications, among others.

Further Reading:

- [Conflict-free replicated data types](http://dl.acm.org/citation.cfm?id=2050642)
- [A comprehensive study of Convergent and Commutative Replicated Data Types](https://hal.inria.fr/inria-00555588)
	
## Datatypes

Included data types are:

- _IntVector_ : An Integer Vector.
- _Counter_ : A grow-only counter.
- _DCounter_ : A counter implementing both increment and decrement operations.
- _GRSet_ : An grow-only set.
- _USet_ : A set supporting both add and remove operations.

Please note that the current implementations are designed only for educational purposes. Don't use them for any serious work.

## Building and Installing

```
make && make install
```

To use this library, compile your files using `ocamlbuild`

```
ocamlbuild -use-ocamlfind -pkgs crdt <your-file>
```

## Usage

For a simple increment / decrement counter:

```ocaml
open DCounter

let a = make () and
	b = make ()

incr a
incr a

query a
- : int = 2

decr b
merge a b

query a
- : int = 1
```

Using an _USet_:

```ocaml
open USet

let s1 = make () and
    s2 = make ()

add s1 "I"
add s1 "Love"

add s2 "Pancakes"
add s1 "Yeah!"

merge s1 s2
merge s2 s1

value s1
- : bytes list = ["I"; "Love"; "Pancakes"; "Yeah!"]

remove s2 "Yeah!"
merge s1 s2

value s1
- : bytes list = ["I"; "Love"; "Pancakes"]

value s2
- : bytes list = ["I"; "Love"; "Pancakes"]
```



## Documentation

### IntVector

```ocaml
type t
type state = int list
val make_of_size : int -> t
val make_with : state -> t
val query : t -> state
val update : int -> t -> unit
val merge : t -> t -> unit
```

### Counter

```ocaml
type t
type state = int list
val make : unit -> t
val make_with : state -> t
val query : t -> int
val incr : t -> unit
val merge : t -> t -> unit
```

### DCounter

```ocaml
type t
type state = int list
val make : unit -> t
val make_with : state -> t
val query : t -> int
val incr : t -> unit
val decr : t -> unit
val merge : t -> t -> unit
```

### GRSet

GRSet is __not__ polymorphic, and only accepts strings (for now).


```ocaml
type t
type elt = string
val make : unit -> t
val value : t -> elt list
val add : t -> elt -> unit
val merge : t -> t -> unit
```

### USet

USet is __not__ polymorphic, and only accepts strings (for now).

```ocaml
type t
type elt = string
val make : unit -> t
val value : t -> elt list
val add : t -> elt -> unit
val remove : t -> elt -> unit
val merge : t -> t -> unit
```

## License

GPLv3. Check the [License](./LICENSE).
