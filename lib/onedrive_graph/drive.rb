# frozen_string_literal: true

module OnedriveGraph
  # Drive class
  class Drive < Hash
    include Hashie::Extensions::MethodAccess
  end
end
