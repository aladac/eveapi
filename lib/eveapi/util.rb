# Utility Hash methods
class Hash
  # Try to get defails on a +Hash+ returned from CREST
  #
  # @return [Hash, Array] return a detailed JSON of a CREST object
  def details
    convert_hash_keys json_get(self[:href]) if self[:href]
  end

  # Generate a ruby method_name from a API Call list +Hash+
  #
  # @return [Symbol] method name
  def ruby_method_name
    (self[:type][0..3].downcase + '_' + self[:name].underscore).to_sym
  end

  # Process rows of API request data, normalize, symbolize
  #
  # @return [Hash] Processed API result
  def process_rows
    case self['rowset']
    when Hash
      normalize_hash_rowset
    when Array
      normalize_array_rowset
    end
    collapse_key
  end

  # Merge the value of the one and only key with the Hash
  #
  # @return [Hash] modified +Hash+
  def collapse_key
    length == 1 ? merge!(delete(keys.first)) : self
  end

  # Cleanup not needed keys from the result
  #
  # @return [Hash] modified +Hash+
  def normalize_hash_rowset
    self[self['rowset']['name']] = self['rowset']['row']
    delete('rowset')
  end

  # Cleanup not needed keys from the result
  #
  # @return [Hash] modified +Hash+
  def normalize_array_rowset
    self['rowset'].each do |rowset|
      self[rowset['name']] = rowset['row']
    end
    delete('rowset')
  end
end

# Utility String methods
class String
  # Camelize +String+
  #
  # @return [String] Camelized +String+
  def camelize
    split('_').each(&:capitalize!).join('')
  end

  # Snake Case a Camelized +String+
  #
  # @return [String] Snake Cased version of the +String+
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
  # Convert +Symbol+ to +String+ EVE API path
  #
  # @return [String] API Path
  def to_path
    parts = to_s.split('_')
    return '' if parts.count < 2
    "/#{parts[0]}/#{parts[1..-1].join('_').camelize}.xml.aspx"
  end
end

module EVEApi
  # Utility methods
  module Util
    #  Make a GET request, parse JSON if present, and process the result
    #
    # @param [String] url URL to Call
    # @param [Hash] args arguments passed to +Excon+
    # @return [Hash] processed result from the CREST API
    def json_get(url, args = {})
      http = Excon.get(url, args).body
      convert_hash_keys(Crack::JSON.parse(http))
    end

    # Make a symbolized and underscored version of a +Symbol+ or +String+
    #
    # @param [String, Symbol] k Key
    # @return [Symbol] modified version of the key
    def underscore_key(k)
      k.to_s.underscore.to_sym
    end

    # Symbolize and underscore all +Hash+ keys
    #
    # @param [Array, Hash] value Object to process
    # @return [Array, Hash] processed output
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
