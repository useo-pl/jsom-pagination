# frozen_string_literal: true

require 'rack'

module JSOM
  module Pagination
    class Links
      DEFAULT_PAGE_SIZE = 20

      def to_h
        {
          first: @first,
          prev: @prev,
          self: @self,
          next: @next,
          last: @last
        }.reject { |_key, value| value.nil? }
      end

      def first
        @first || generate_url(1)
      end

      def last
        @last || generate_url(total_pages)
      end

      attr_reader :prev, :next, :self

      private

      attr_reader :page, :total_pages, :url

      def initialize(page:, url:, total_pages:)
        @url = parse_url(url)
        @page = page
        @total_pages = total_pages
        generate_links
      end

      def parse_url(url)
        uri = URI.parse(URI.unescape(url))
        url_params = Rack::Utils.parse_nested_query(
          uri.query
        ).delete_if { |key, _value| key == 'page' }
        uri.query = to_query(url_params)
        uri.query = nil if uri.query.empty?
        uri
      end

      def generate_links
        if page.number > 1
          @first = generate_url(1)
          @prev = generate_url(page.number - 1)
        end
        @self = generate_url(page.number)

        return unless page.number < total_pages

        @next = generate_url(page.number + 1)
        @last = generate_url(total_pages)
      end

      def generate_url(page_number)
        separator = url.to_s.include?('?') ? '&' : '?'
        [url.to_s, url_params(page_number)].reject(&:empty?).join(separator)
      end

      def url_params(page_number)
        url_params = {}
        url_params[:page] = {} if include_per_page? || include_page?(page_number)
        url_params[:page][:number] = page_number if include_page?(page_number)
        url_params[:page][:size] = page.size if include_per_page?
        to_query(url_params)
      end

      def to_query(obj, namespace = '')
        query = obj.collect do |key, value|
          if value.is_a?(Hash)
            to_query(value, namespace.empty? ? key : "#{namespace}[#{key}]")
          else
            if namespace.empty?
              [key, value].join('=')
            else
              ["#{namespace}[#{key}]", value].join('=')
            end
          end
        end.compact

        query.join('&')
      end

      def include_per_page?
        page.size != DEFAULT_PAGE_SIZE
      end

      def include_page?(page_number)
        page_number > 1
      end
    end
  end
end
