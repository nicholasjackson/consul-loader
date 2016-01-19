module ConsulLoader
  class ConfigParser
    attr_accessor :config

    def initialize
      self.config = []
    end

    def process_yaml root, hash
      keys = []
      return [] unless hash

      hash.each do |key, value|
        if value.is_a?(Hash)
          process_yaml(root + "/" + key, value).each do |k|
            keys << k
          end
        else
          keys << {:k => root + "/" + key, :v => value}
        end
      end
      return keys
    end
  end
end
