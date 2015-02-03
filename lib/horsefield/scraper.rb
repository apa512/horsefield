require 'uri'
require 'open-uri'
require 'nokogiri'

module Horsefield
  module Scraper
    def self.included(base)
      base.extend(ClassMethods)
    end

    def initialize(html_or_url)
      @doc = Nokogiri::HTML(html_or_url =~ /\A#{URI::regexp}\Z/ ? open(html_or_url).read : html_or_url)
    end

    def [](field)
      fields[field]
    end

    def scrape
      fields
    end

    def fields
      @fields ||= self.class.lookups.reduce({}) { |fields, l| fields.merge(l.call(@doc)) }.
        instance_eval(&self.class.postprocessor)
    end

    module ClassMethods
      def lookups
        @lookups ||= []
      end

      def postprocessor
        @postprocessor || Proc.new { self }
      end

      def one(name, selector, lookup = :optional, &block)
        self.lookups << lambda { |doc| doc.one(name, selector, lookup, &block) }
      end

      def many(name, selector, lookup = :optional, &block)
        self.lookups << lambda { |doc| doc.many(name, selector, lookup, &block) }
      end

      def many!(name, selector, &block)
        many(name, selector, :required, &block)
      end

      def many?(name, selector, &block)
        many(name, selector, :presence, &block)
      end

      def one!(name, selector = nil, &block)
        one(name, selector, :required, &block)
      end

      def one?(name, selector = nil, &block)
        one(name, selector, :presence, &block)
      end

      def scope(selector, &block)
        self.lookups << lambda { |doc| doc.at(selector).instance_eval(&block) }
      end

      def postprocess(&block)
        @postprocessor = block
      end
    end
  end
end
