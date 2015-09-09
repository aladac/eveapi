class Hash
  def process_rows
    case self['rowset']
    when Hash
      self.merge!(self['rowset']['name'] => self['rowset']['row'])
      self.delete('rowset')
    when Array
      self['rowset'].each do |rowset|
        self[rowset['name']] = rowset['row']
      end
      self.delete('rowset')
    end
    self.merge!(self.delete(self.keys.first)) if self.length == 1
    return self
  end
end

module EVEApi
  module Util
    def underscore_key(k)
      k.to_s.underscore.to_sym
    end

    def convert_hash_keys(value)
      case value
      when Array
        value.map { |v| convert_hash_keys(v) }
      when Hash
        Hash[value.map { |k, v| [underscore_key(k), convert_hash_keys(v)] }]
      else
        value
      end
    end
  end
end
