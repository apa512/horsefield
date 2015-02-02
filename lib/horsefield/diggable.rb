module Horsefield
  module Diggable
    def many(name, selector, lookup = :optional, &block)
      docs = search(selector)
      raise MissingSelectorError if lookup == :required && docs.empty?
      nodes = docs.map do |doc|
        doc.instance_eval(&processor(&block))
      end

      fields.merge!(Hash[[[name, nodes]]])
    end

    def many!(name, selector, &block)
      many(name, selector, :required, &block)
    end

    def one(name, selector = nil, lookup = :optional, &block)
      doc = selector ? at(selector) : self
      raise MissingSelectorError if lookup == :required && !doc
      fields.merge!(Hash[[[name, doc && doc.instance_eval(&processor(&block))]]])
    end

    def one!(name, selector = nil, &block)
      one(name, selector, :required, &block)
    end

    def processor(&block)
      block || Proc.new { text.strip }
    end

    def fields
      @fields ||= {}
    end
  end

  class MissingSelectorError < StandardError; end
end
