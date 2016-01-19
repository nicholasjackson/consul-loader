module ConsulLoader
  class Loader

    attr_accessor :parser

    def initialize parser
      self.parser = parser
    end

    def load_config location, server
      if File.directory? location
        load_folder location, server
      elsif
        load_file_and_upload location, server
      else
        raise Errno::ENOENT
      end
    end

    :private

    def load_folder folder, server
      Dir.glob("#{folder}/*.yaml").each do |x|
        load_file_and_upload x, server
      end
    end

    def load_file_and_upload filename, server
      yaml = YAML.load_file(filename)
      self.parser.process_yaml("", yaml).each {|k|
        upload_config k, server
      }
    end

    def upload_config c, server
      case c[:v]
      when Array
        value = c[:v].to_json
      when String, Fixnum, TrueClass
        value = c[:v]
      end

      RestClient.put "#{server}/v1/kv/#{c[:k]}", value
    end
  end
end
