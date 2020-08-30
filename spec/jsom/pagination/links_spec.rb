# frozen_string_literal: true

module JSOM::Pagination
  RSpec.describe Links do
    let(:url) { 'https://example.com/articles' }

    context 'when first page and default size' do
      let(:page) { Page.new(number: 1) }

      it 'sets the self link only for the single page' do
        links = described_class.new(url: url, page: page, total_pages: 1)
        expect(links.self).to eq('https://example.com/articles')
        expect(links.prev).to be_nil
        expect(links.first).to eq('https://example.com/articles')
        expect(links.next).to be_nil
        expect(links.last).to eq('https://example.com/articles')

        expect(links.to_h).to eq(self: 'https://example.com/articles')
      end

      it 'sets the self, next and last when not last page' do
        links = described_class.new(url: url, page: page, total_pages: 3)

        expect(links.self).to eq('https://example.com/articles')
        expect(links.prev).to be_nil
        expect(links.first).to eq('https://example.com/articles')
        expect(links.next).to eq('https://example.com/articles?page[number]=2')
        expect(links.last).to eq('https://example.com/articles?page[number]=3')

        expect(links.to_h).to eq(
          self: 'https://example.com/articles',
          next: 'https://example.com/articles?page[number]=2',
          last: 'https://example.com/articles?page[number]=3'
        )
      end
    end

    context 'when non-first page and default size' do
      let(:page) { Page.new(number: 2) }

      it 'sets the self link only for the single page' do
        links = described_class.new(url: url, page: page, total_pages: 2)

        expect(links.self).to eq('https://example.com/articles?page[number]=2')
        expect(links.prev).to eq('https://example.com/articles')
        expect(links.first).to eq('https://example.com/articles')
        expect(links.next).to be_nil
        expect(links.last).to eq('https://example.com/articles?page[number]=2')

        expect(links.to_h).to eq(
          self: 'https://example.com/articles?page[number]=2',
          prev: 'https://example.com/articles',
          first: 'https://example.com/articles'
        )
      end

      it 'sets the self, next and last when not last page' do
        links = described_class.new(url: url, page: page, total_pages: 3)

        expect(links.to_h).to eq(
          self: 'https://example.com/articles?page[number]=2',
          prev: 'https://example.com/articles',
          first: 'https://example.com/articles',
          next: 'https://example.com/articles?page[number]=3',
          last: 'https://example.com/articles?page[number]=3'
        )
      end
    end

    context 'when first page and custom size' do
      let(:page) { Page.new(number: 1, size: 2) }

      it 'sets the self link only for the single page' do
        links = described_class.new(url: url, page: page, total_pages: 1)

        expect(links.self).to eq('https://example.com/articles?page[size]=2')
        expect(links.prev).to be_nil
        expect(links.first).to eq('https://example.com/articles?page[size]=2')
        expect(links.next).to be_nil
        expect(links.last).to eq('https://example.com/articles?page[size]=2')

        expect(links.to_h).to eq(self: 'https://example.com/articles?page[size]=2')
      end

      it 'sets the self, next and last when not last page' do
        links = described_class.new(url: url, page: page, total_pages: 3)

        expect(links.self).to eq('https://example.com/articles?page[size]=2')
        expect(links.prev).to be_nil
        expect(links.first).to eq('https://example.com/articles?page[size]=2')
        expect(links.next).to eq('https://example.com/articles?page[number]=2&page[size]=2')
        expect(links.last).to eq('https://example.com/articles?page[number]=3&page[size]=2')

        expect(links.to_h).to eq(
          self: 'https://example.com/articles?page[size]=2',
          next: 'https://example.com/articles?page[number]=2&page[size]=2',
          last: 'https://example.com/articles?page[number]=3&page[size]=2'
        )
      end
    end

    context 'when non-first page and custom size' do
      let(:page) { Page.new(number: 2, size: 2) }

      it 'sets the self link only for the single page' do
        links = described_class.new(url: url, page: page, total_pages: 2)

        expect(links.self).to eq('https://example.com/articles?page[number]=2&page[size]=2')
        expect(links.prev).to eq('https://example.com/articles?page[size]=2')
        expect(links.first).to eq('https://example.com/articles?page[size]=2')
        expect(links.next).to be_nil
        expect(links.last).to eq('https://example.com/articles?page[number]=2&page[size]=2')

        expect(links.to_h).to eq(
          self: 'https://example.com/articles?page[number]=2&page[size]=2',
          prev: 'https://example.com/articles?page[size]=2',
          first: 'https://example.com/articles?page[size]=2'
        )
      end

      it 'sets the self, next and last when not last page' do
        links = described_class.new(url: url, page: page, total_pages: 3)

        expect(links.self).to eq('https://example.com/articles?page[number]=2&page[size]=2')
        expect(links.prev).to eq('https://example.com/articles?page[size]=2')
        expect(links.first).to eq('https://example.com/articles?page[size]=2')
        expect(links.next).to eq('https://example.com/articles?page[number]=3&page[size]=2')
        expect(links.last).to eq('https://example.com/articles?page[number]=3&page[size]=2')

        expect(links.to_h).to eq(
          self: 'https://example.com/articles?page[number]=2&page[size]=2',
          prev: 'https://example.com/articles?page[size]=2',
          first: 'https://example.com/articles?page[size]=2',
          next: 'https://example.com/articles?page[number]=3&page[size]=2',
          last: 'https://example.com/articles?page[number]=3&page[size]=2'
        )
      end
    end
  end
end