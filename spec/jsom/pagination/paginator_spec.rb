# frozen_string_literal: true

require 'jsom/pagination/paginator'

module JSOM
  module Pagination
    RSpec.describe Paginator do
      subject { described_class.new }

      describe '#call' do
        context 'when collection is an array' do
          let(:collection) { [1, 2, 3, 4, 5, 6, 7] }

          it 'returns a collection of paginated records' do
            params = { number: 2, size: 2 }
            paginated = subject.call(collection, params: params)
            expect(paginated.items).to eq([3, 4])
          end

          it 'returns a collection of paginated records' do
            params = { number: 2, size: 2 }
            paginated = subject.call(collection, params: params)
            expect(paginated.items).to eq([3, 4])
          end
        end

        context 'when collection is an object responding to #all' do
          let(:collection) { DummyCollection.new }

          it 'returns a collection of paginated records' do
            params = { number: 2, size: 2 }
            paginated = subject.call(collection, params: params)
            expect(paginated.items).to eq([3, 4])
          end

          it 'returns a collection of paginated records' do
            params = { number: 2, size: 2 }
            paginated = subject.call(collection, params: params)
            expect(paginated.items).to eq([3, 4])
          end
        end
      end
    end

    class DummyCollection
      attr_reader :items

      def count
        all.length
      end

      def offset(number)
        tap { @items = items[number, all.size] }
      end

      def limit(number)
        tap { @items = items[0, number] }
      end

      def to_a
        items
      end

      private

      attr_reader :all

      def initialize
        @all = [1, 2, 3, 4, 5, 6, 7]
        @items = @all.dup
      end
    end
  end
end
