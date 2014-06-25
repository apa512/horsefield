module Horsefield
  module Diggable
    def scope(selector, &block)
      doc = at(selector)
      doc.instance_eval(&block)
      @nodes = nodes.merge(doc.nodes)
    end

    def one(name, selector, &block)
      self.nodes[name] = at(selector) && at(selector).instance_eval(&processor(&block))
    end

    def many(name, selector, &block)
      self.nodes[name] = search(selector).map do |doc|
        doc.instance_eval(&processor(&block))
        doc.nodes
      end
    end

    def processor(&block)
      block || Proc.new { text.strip }
    end

    def nodes
      @nodes ||= {}
    end
  end
end
