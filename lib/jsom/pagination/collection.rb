# frozen_string_literal: true

module JSOM
  module Pagination
    class Collection < Dry::Struct
      attribute :items, Types::Strict::Array
      attribute :meta, Types.Instance(MetaData)
      attribute :links, Types::Instance(Links)
    end
  end
end
