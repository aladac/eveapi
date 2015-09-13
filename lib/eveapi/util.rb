# Utility Hash methods
class Hash
  def details
    convert_hash_keys json_get(self[:href]) if self[:href]
  end

  def ruby_method_name
    (self[:type][0..3].downcase + '_' + self[:name].underscore).to_sym
  end

  def process_rows
    case self['rowset']
    when Hash
      normalize_hash_rowset
    when Array
      normalize_array_rowset
    end
    collapse_key
  end

  def collapse_key
    length == 1 ? self.merge!(delete(keys.first)) : self
  end

  def normalize_hash_rowset
    self.merge!(self['rowset']['name'] => self['rowset']['row'])
    delete('rowset')
  end

  def normalize_array_rowset
    self['rowset'].each do |rowset|
      self[rowset['name']] = rowset['row']
    end
    delete('rowset')
  end
end

# Utility String methods
class String
  def camelize
    split('_').each(&:capitalize!).join('')
  end

  # Stolen from ActiveSupport::Inflector
  def underscore
    return self unless self =~ /[A-Z-]|::/
    word = to_s.gsub(/::/, '/')
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    word.tr!('-', '_')
    word.downcase!
    word
  end
end

# Utility Symbol methods
class Symbol
  def to_path
    parts = to_s.split('_')
    return '' if parts.count < 2
    "/#{parts[0]}/#{parts[1..-1].join('_').camelize}.xml.aspx"
  end
end

module EVEApi
  # Utility methods
  module Util
    def json_get(url, args = {})
      http = Excon.get(url, args).body
      convert_hash_keys(Crack::JSON.parse http)
    end

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
