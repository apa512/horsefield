require 'uri'
require 'open-uri'
require 'horsefield/nokogiri'

module Horsefield
  class Scraper
    def initialize(url_or_html)
      @url_or_html = url_or_html
    end

    def scrape(&block)
      doc = Nokogiri::HTML(html)
      doc.instance_eval(&block)
      doc.nodes
    end

    def html
      @html ||= @url_or_html =~ /\A#{URI::regexp}\Z/ ? open(@url_or_html).read : @url_or_html
    end
  end
end
