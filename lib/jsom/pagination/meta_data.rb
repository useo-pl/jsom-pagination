# frozen_string_literal: true

require 'dry-struct'
require 'jsom/pagination/types'

module JSOM
  module Pagination
    class MetaData < Dry::Struct
      transform_keys(&:to_sym)

      attribute :total, Types::Params::Integer
      attribute :pages, Types::Params::Integer
    end
  end
end
