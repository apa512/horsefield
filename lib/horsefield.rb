require 'nokogiri'
require "horsefield/version"
require "horsefield/scraper"

module Horsefield
  def self.scrape(url_or_html, &block)
    Horsefield::Scraper.new(url_or_html).scrape(&block)
  end
end
