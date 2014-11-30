module Horsefield
  module Diggable
    attr_writer :nodes

    def scope(selector, &block)
      doc = at(selector)
      return unless doc
      doc.instance_eval(&block)
      @nodes = nodes.merge(doc.nodes)
    end

    def one(name, selector = nil, &block)
      doc = selector ? at(selector) : self.clone.tap { |s| s.nodes = {} }
      self.nodes[name] = doc && doc.instance_eval(&processor(&block))
      self.nodes
    end

    def many(name, selector, &block)
      self.nodes[name] = search(selector).map do |doc|
        doc.instance_eval(&processor(&block))
      end

      self.nodes
    end

    def processor(&block)
      block || Proc.new { text.strip }
    end

    def nodes
      @nodes ||= {}
    end
  end
end
