# Consul returns responses like so...
#[{"CreateIndex":7809,"ModifyIndex":32838,"LockIndex":0,"Key":"api/eventsauce/retry_intervals","Flags":0,"Value":"WyIxMHMiLCIxbSIsIjE1bSIsIjFoIiwiMWQiXQ=="}]
module ConsulLoader
  class ResponseDecoder
    def decode_value response
      return nil if response == nil

      json = JSON.parse response

      return nil if json == nil
      return nil if json[0]["Value"] == nil

      base64_decode json[0]["Value"]
    end

    def base64_decode value
      begin
        return Base64.strict_decode64(value)
      rescue
        return nil
      end
    end
  end
end
