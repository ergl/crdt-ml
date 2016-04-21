(** A collection of mutable and immutable CRDTs.

  This module is meant to be opened to use both mutable and immutable
  structures in the same codebase. To use, for example, and [ORSet], you can
  choose to use either [Mutable.ORSet] or [Immutable.ORSet]. *)

(** A collection of mutable CRDTs *)
module Mutable = struct
  module IntVector = M_IntVector
  module GCounter = M_GCounter
  module PNCounter = M_PNCounter
  module GSet = M_GSet
  module ORSet = M_ORSet
  module USet = M_USet
end

(** A collection of immutable CRDTs *)
module Immutable = struct
  module IntVector = I_IntVector
  module GCounter = I_GCounter
  module PNCounter = I_PNCounter
  module GSet = I_GSet
  module ORSet = I_ORSet
  module USet = I_USet
end
