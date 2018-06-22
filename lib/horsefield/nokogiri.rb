require 'nokogiri'

module Horsefield
  [Nokogiri::HTML::Document,
   Nokogiri::XML::Document,
   Nokogiri::XML::Element,
   Nokogiri::XML::Attr,
   Nokogiri::XML::Text].each do |klass|
    klass.send(:include, Diggable)
  end
end
