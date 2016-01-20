# consul-loader
Consul Loader is a simple gem to convert a yaml file into a series of consul keys and values.  Consul Loader will traverse your yaml file and generate a key from the location of each value.  For example you have a yaml file like the example below:
```
first: 'one'
api:
  eventsauce:
    stats_d_server_url: 'statsd:8125'

```
This would generate two consul keys:  
| key                                | value       |
| ---------------------------------- | ----------- |
| /first                             | one         |
| /api/eventsauce/stats_d_server_url | statsd:8125 |

If your yaml file contains an array of values then Consul Loader would convert this into a json formatted array. For example:
```
retry_intervals:
  - '1s'
  - '1m'
  - '15m'
  - '1h'
  - '1d'
```
Would result in the below consul key:
| key                                | value                        |
| ---------------------------------- | ---------------------------- |
| /retry_intervals                   | ["10s","1m","15m","1h","1d"] |


Consul Loader always checks the value of the existing key, if it matches the current key then this is not overwritten to ensure consul-template or any other clients watching the kv store will update incorrectly.

## Usage to load a folder of .yaml files
```
  loader = ConsulLoader::Loader.new(ConsulLoader::ConfigParser.new)
  loader.load_config './config', 'http://consul.myhost.com:8500'
```

## Usage to load a single yaml file
```
  loader = ConsulLoader::Loader.new(ConsulLoader::ConfigParser.new)
  loader.load_config './config/myfile.yml', 'http://consul.myhost.com:8500'
```

## Example yaml config
```
first: 'one'
api:
  eventsauce:
    stats_d_server_url: 'statsd:8125'
    data_store:
      connection_string: 'mongodb://mongo/event-sauce'
      database_name: 'event-sauce'
    queue:
      connection_string: 'redis:6379'
      event_queue: 'event_queue'
      dead_letter_queue: 'dead_letter_queue'
    retry_intervals:
      - '1s'
      - '1m'
      - '15m'
      - '1h'
      - '1d'
```

## TODO:
* Add auth for Consul server.
