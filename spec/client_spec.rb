require 'spec_helper'

describe Cfyg::Client do
  before(:each) do
    stub_request(:post, "http://127.0.0.1:8545/").
      with(
        body: "{\"jsonrpc\":\"2.0\",\"method\":\"eth_syncing\",\"params\":[],\"id\":1}",
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'Host'=>'127.0.0.1',
          'User-Agent'=>'Ruby'
        }).
        to_return(status: 200, body: "{\"jsonrpc\":\"2.0\",\"id\":1,\"result\":false}\n", headers: {})
  end
  it 'sends remote command to geth' do
    response = Cfyg::Client.new.send(method: "eth_syncing")
    expect(response.result).to be false
  end

end
