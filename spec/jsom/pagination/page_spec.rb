# frozen_string_literal: true

module JSOM
  module Pagination
    RSpec.describe Page do
      it 'sets defaults for missing params' do
        page = Page.new

        expect(page.number).to eq(1)
        expect(page.size).to eq(20)
      end

      it 'sets defaults for nil values' do
        page = Page.new(size: nil, number: nil)

        expect(page.number).to eq(1)
        expect(page.size).to eq(20)
      end

      it 'allows to override defaults with integers' do
        page = Page.new(size: 4, number: 2)

        expect(page.number).to eq(2)
        expect(page.size).to eq(4)
      end

      it 'treats string values as integers' do
        page = Page.new(size: '4', number: '2')

        expect(page.number).to eq(2)
        expect(page.size).to eq(4)
      end

      it 'treats string keys as symbols' do
        page = Page.new('size' => 4, 'number' => 2)

        expect(page.number).to eq(2)
        expect(page.size).to eq(4)
      end

      it 'treats negative numbers as defaults' do
        page = Page.new(size: -4, number: -2)

        expect(page.number).to eq(1)
        expect(page.size).to eq(1)
      end
    end
  end
end
