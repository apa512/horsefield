require 'nokogiri'

module Horsefield
  class Nokogiri::HTML::Document
    include Diggable
  end

  class Nokogiri::XML::Element
    include Diggable
  end
end
