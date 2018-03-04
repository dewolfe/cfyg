# frozen_string_literal: true
# curl -X POST --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}'

module Cfyg
  class Client
    attr_accessor :request, :http

    def initialize(**args)
      rpc_client_url = URI.parse(args.fetch(:uri, 'http://127.0.0.1'))
      rpc_client_port = args.fetch(:port, '8545')
      header = { 'Content-Type': 'application/json' }
      @http = Net::HTTP.new(rpc_client_url.host, rpc_client_port)
      @request = Net::HTTP::Post.new(rpc_client_url, header)
    end

    def send(method:, params: [], id: 1)
      request.body = { jsonrpc: '2.0', method: method, params: params, id: id }.to_json
      Response.new(response: http.request(request))
    end
  end
end
