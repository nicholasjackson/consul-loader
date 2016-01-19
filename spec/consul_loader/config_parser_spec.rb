require 'spec_helper'

describe ConsulLoader::ConfigParser do

  subject(:parser) { ConsulLoader::ConfigParser.new }

  context 'initialize' do
    it 'should set config to a blank array' do
      expect(parser.config).to eq([])
    end

  end

  context 'read values' do
    let(:config) {
      yaml = YAML.load_file(File.dirname(__FILE__) + '/../data/example1.yaml')
      parser.process_yaml "", yaml
    }

    it 'should store the value of the first key as a string' do
      expect(config[0][:k]).to eq('/first')
      expect(config[0][:v]).to eq('one')
    end

    it 'should recurse into the tree when the yaml value is a hash' do
      expect(config[1][:k]).to eq('/api/eventsauce/stats_d_server_url')
      expect(config[1][:v]).to eq('statsd:8125')
    end
  end
end
