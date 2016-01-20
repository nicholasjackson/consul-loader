Gem::Specification.new do |s|
  s.name        = 'consul_loader'
  s.version     = '0.0.0'
  s.date        = '2016-01-19'
  s.summary     = "Consul loader allows you to import a yaml file into  Consul's key value store."
  s.description = "Use consul loader to convert your heirachical yaml file into key value paths in consul, this may be useful if you want to load a config file into your consul server."
  s.authors     = ["Nic Jackson"]
  s.email       = 'jackson.nic@gmail.com'
  s.files       = ["lib/consul_loader.rb", "lib/consul_loader/loader.rb", "lib/consul_loader/config_parser.rb", "lib/consul_loader/response_decoder.rb"]
  s.homepage    =
    'https://github.com/nicholasjackson/consul-loader'
  s.license       = 'MIT'

  s.add_development_dependency "rspec"
  s.add_development_dependency 'rake'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'pry'

  s.add_runtime_dependency "rest-client"
end
