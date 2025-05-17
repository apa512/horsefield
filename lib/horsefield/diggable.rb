module Horsefield
  module Diggable
    def with_fresh_fields
      @fields = {}
      self
    end

    def many(name, selector, lookup = :optional, &block)
      docs = search(selector)

      raise MissingSelectorError, "Couldn't find required selector (#{selector})" if lookup == :required && docs.empty?
      return fields if lookup == :presence && docs.empty?

      nodes = docs.map do |doc|
        doc.instance_eval(&processor(&block))
      end

      fields.merge!(Hash[[[name, nodes]]])
    end

    def one(name, selector = nil, lookup = :optional, &block)
      doc = selector ? at(selector) : self.dup

      raise MissingSelectorError, "Couldn't find required selector (#{selector})" if lookup == :required && !doc
      return fields if lookup == :presence && !doc

      if block
        # Process the sub-document
        sub_doc = doc && doc.with_fresh_fields
        
        # Run the block to populate fields and get its return value
        return_value = sub_doc && sub_doc.instance_eval(&block)
        
        # Use fields if they were populated, otherwise use the block's return value
        value = (sub_doc && !sub_doc.fields.empty?) ? sub_doc.fields : return_value
        
        fields.merge!(Hash[[[name, value]]])
      else
        fields.merge!(Hash[[[name, doc && doc.text.strip]]])
      end
    end

    def many!(name, selector, &block)
      many(name, selector, :required, &block)
    end

    def many?(name, selector, &block)
      many(name, selector, :presence, &block)
    end

    def one!(name, selector = nil, &block)
      one(name, selector, :required, &block)
    end

    def one?(name, selector = nil, &block)
      one(name, selector, :presence, &block)
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
