require 'nokogiri'
require 'horsefield/diggable'

module Horsefield
  class Nokogiri::HTML::Document
    include Diggable
  end

  class Nokogiri::XML::Element
    include Diggable
  end
end
