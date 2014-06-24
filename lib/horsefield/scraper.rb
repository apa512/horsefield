require 'uri'
require 'open-uri'

module Horsefield
  class Scraper
    def initialize(url_or_html)
      @url_or_html = url_or_html
    end

    def html
      @html ||= @url_or_html =~ /\A#{URI::regexp}\Z/ ? open(@url_or_html).read : @url_or_html
    end
  end
end
