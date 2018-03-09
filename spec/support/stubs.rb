RSpec.configure do |config|
  config.before(:each) do
    stub_request(:post, "http://127.0.0.1:8545/").
      with(
        body: hash_including({"method"=>"eth_sendTransaction","id" => 1}),
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'Host'=>'127.0.0.1',
          'User-Agent'=>'Ruby'
        }).
        to_return(status: 200, body: "{\"jsonrpc\":\"2.0\",\"id\":1,\"result\":\"0xfb3b0a94d8edc7d54485702bd353fe13f24901e53d336caee40e16125a37f744\"}\n", headers: {})

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
end
