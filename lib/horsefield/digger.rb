module Horsefield
  class Digger
    def initialize(nokogiri_doc, fields = {})
      @nokogiri_doc = nokogiri_doc
      @fields = fields
    end
  end
end
