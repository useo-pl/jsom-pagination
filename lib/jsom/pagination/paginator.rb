# frozen_string_literal: true

module JSOM
  module Pagination
    class Paginator
      def call(collection, params:, base_url: '')
        @page = Page.new(params)

        pagy, records = pagy_custom(collection, page: page)

        meta = MetaData.new(total: pagy.count, pages: pagy.pages)
        # pagy methods: :count, :page, :items, :vars, :pages, :last, :offset, :from, :to, :prev, :next
        links = Links.new(page: page, total_pages: pagy.pages, url: base_url)
        Collection.new(items: records, links: links, meta: meta)
      end

      private

      attr_reader :page

      def pagy_custom(collection, page:)
        pagy = Pagy.new(count: collection.count, page: page.number, items: page.size)
        paginated =
          if collection.is_a?(Array)
            collection[pagy.offset, pagy.items]
          else
            collection.offset(pagy.offset).limit(pagy.items).to_a
          end
        [pagy, paginated]
      end
    end
  end
end
