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

      check_and_send_value c[:k], value, server
    end

    def check_and_send_value key, value, server
      send_data = true

      begin
        response = RestClient.get "#{server}/v1/kv#{key}"
        decoder = ConsulLoader::ResponseDecoder.new
        existing_value = decoder.decode_value response.body
        if value.to_s == existing_value.to_s
          send_data = false
        end
      rescue
        send_data = true
      end

      if send_data
        puts "Updating key: #{key} with value: #{value}"
        RestClient.put "#{server}/v1/kv#{key}", value.to_s
      end
    end
  end
end
