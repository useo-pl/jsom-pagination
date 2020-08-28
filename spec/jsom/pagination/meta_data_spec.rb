# frozen_string_literal: true

module JSOM
  module Pagination
    RSpec.describe MetaData do
      it 'sets proper attributes for metadata' do
        data = MetaData.new(total: 10, pages: 20)

        expect(data.total).to eq(10)
        expect(data.pages).to eq(20)
        expect(data.to_h).to eq(total: 10, pages: 20)
      end

      it 'raises an error for missing total' do
        expect { MetaData.new(pages: 20) }.to raise_error(Dry::Struct::Error)
      end

      it 'raises an error for missing pages' do
        expect { MetaData.new(total: 20) }.to raise_error(Dry::Struct::Error)
      end

      it 'does except string values' do
        data = MetaData.new(total: '10', pages: '20')

        expect(data.total).to eq(10)
        expect(data.pages).to eq(20)
        expect(data.to_h).to eq(total: 10, pages: 20)
      end
    end
  end
end
