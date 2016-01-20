require 'spec_helper'

describe ConsulLoader::ResponseDecoder do

  subject(:decoder) { ConsulLoader::ResponseDecoder.new }

  it 'succesfully decodes a value when present from base64' do
    value = decoder.decode_value '[{"CreateIndex":7809,"ModifyIndex":32838,"LockIndex":0,"Key":"api/eventsauce/retry_intervals","Flags":0,"Value":"WyIxMHMiLCIxbSIsIjE1bSIsIjFoIiwiMWQiXQ=="}]'

    expect(value).to eq('["10s","1m","15m","1h","1d"]')
  end

  it 'returns nil when a value is not present' do
    value = decoder.decode_value '
    [{"CreateIndex":7809,"ModifyIndex":32838,"LockIndex":0,"Key":"api/eventsauce/retry_intervals","Flags":0}]'
    expect(value).to be_nil
  end

  it 'returns nil when the returned value is not encoded as base64' do
    value = decoder.decode_value <<-eos
    [{"CreateIndex":7809,"ModifyIndex":32838,"LockIndex":0,"Key":"api/eventsauce/retry_intervals","Flags":0,"Value":"abc"}]
    eos
    expect(value).to be_nil
  end

  it 'returns nil when the response is nil' do
    value = decoder.decode_value nil
    expect(value).to be_nil
  end

end
