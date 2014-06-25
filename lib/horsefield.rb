require 'nokogiri'
require "horsefield/version"

module Horsefield
  def self.scrape(url_or_html, &block)
    Horsefield::Scraper.new(url_or_html).scrape(&block)
  end
end
