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
      @fields ||= self.class.lambdas.reduce({}) { |fields, l| fields.merge(l.call(@doc)) }
    end

    module ClassMethods
      @@lambdas = []

      def lambdas
        @@lambdas
      end

      def one(name, selector, lookup = :optional, &block)
        self.lambdas << lambda { |doc| doc.one(name, selector, lookup, &block) }
      end

      def many(name, selector, lookup = :optional, &block)
        self.lambdas << lambda { |doc| doc.many(name, selector, lookup, &block) }
      end

      def scope(selector, &block)
        self.lambdas << lambda { |doc| doc.at(selector).instance_eval(&block) }
      end
    end
  end
end
