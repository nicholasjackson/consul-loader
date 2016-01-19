require 'spec_helper'

describe ConsulLoader::Loader do

  let(:mock_parser) {
    dbl = double("MockParser")
    allow(dbl).to receive(:process_yaml).and_return([{:k => "abc", :v => "123"}])
    dbl
  }

  subject(:loader) { ConsulLoader::Loader.new mock_parser}

  before do
    stub_request(:put, "http://myserver.com/v1/kv/abc")
  end

  context 'loading files' do
    it 'should succesfully call the parser with the given config file' do
      expect(mock_parser).to receive(:process_yaml).once

      loader.load_config File.dirname(__FILE__) + '/../data/example1.yaml', 'http://myserver.com'
    end

    it 'should succesfully call the parser for each config file in the folder' do
      expect(mock_parser).to receive(:process_yaml).twice

      loader.load_config File.dirname(__FILE__) + '/../data', 'http://myserver.com'
    end


    it 'should raise an exception when a file is not found' do
      expect {
        loader.load_config File.dirname(__FILE__) + '/../nofile.yaml', 'http://myserver.com'
      }.to raise_error(Errno::ENOENT)
    end
  end

  context 'send data to consul' do
    it 'should not update the key in consul if the current key has the same value' do
      loader.load_config File.dirname(__FILE__) + '/../data/example1.yaml', 'http://myserver.com'

      expect(WebMock).to have_requested(:put, "http://myserver.com/v1/kv/abc").once
    end

    it 'should update the key in consul when consul has no key' do

    end

    it 'should update the key in consul when the current key is different' do

    end

    it 'should convert the value to json when the value is an array' do

    end

    it 'should send the exact value when the value is a string' do

    end

    it 'should send the exact value when the value is a boolean' do

    end

    it 'should send the exact value when the value is a number' do

    end
  end

end
