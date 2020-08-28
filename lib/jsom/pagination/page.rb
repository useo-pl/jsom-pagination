# frozen_string_literal: true

require 'dry-struct'
require 'jsom/pagination/types'

module JSOM
  module Pagination
    # A value object for requested page. Usage:
    # JSOM::Pagination::Page.new(number: 1, size: 20)
    # Works for string values and symbols, supports defaults.
    # Ignores extra keys
    # Sets 1 for negative values
    #
    class Page < Dry::Struct
      transform_keys(&:to_sym)

      transform_types do |type|
        return type unless type.default?

        type.constructor do |value|
          if value.nil?
            Dry::Types::Undefined
          elsif value == Dry::Types::Undefined
            value
          elsif Dry::Types['params.integer'][value].negative?
            1
          else
            value
          end
        end
      end

      attribute :number, Types::Params::Integer.default(1)
      attribute :size, Types::Params::Integer.default(20)
    end
  end
end
