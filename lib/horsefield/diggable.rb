module Horsefield
  module Diggable
    def scope(selector, &block)
      doc = at(selector)
      doc.instance_eval(&block)
      @attrs = attrs.merge(doc.attrs)
    end

    def one(name, selector = nil, &block)
      doc = selector ? at(selector) : self
      self.attrs[name] = doc && doc.instance_eval(&processor(&block))
    end

    def many(name, selector = nil, &block)
      doc = selector ? search(selector) : self
      self.attrs[name] = doc.map do |doc|
        doc.instance_eval(&processor(&block))
        doc.attrs
      end
    end

    def processor(&block)
      block || Proc.new { text.strip }
    end

    def attrs
      @attrs ||= {}
    end
  end
end
