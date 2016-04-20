module Mutable = struct
  module IntVector = M_IntVector
  module GCounter = M_GCounter
  module PNCounter = M_PNCounter
  module GSet = M_GSet
  module ORSet = M_ORSet
  module USet = M_USet
end

module Immutable = struct
  module IntVector = I_IntVector
  module GCounter = I_GCounter
  module PNCounter = I_PNCounter
  module GSet = I_GSet
  module ORSet = I_ORSet
  module USet = I_USet
end
