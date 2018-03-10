# frozen_string_literal: true

module Cfyg
  class Client
    attr_accessor :request, :http, :id

    def initialize(**args)
      rpc_client_url = URI.parse(args.fetch(:uri, 'http://127.0.0.1'))
      rpc_client_port = args.fetch(:port, '8545')
      header = { 'Content-Type': 'application/json' }
      @id = args.fetch(:id, 1)
      @http = Net::HTTP.new(rpc_client_url.host, rpc_client_port)
      @request = Net::HTTP::Post.new(rpc_client_url, header)
    end

    def send(method:, params: [], id: self.id)
      request.body = { jsonrpc: '2.0', method: method,
                       params: params, id: id }.to_json
      Response.new(response: http.request(request))
    end
  end
end
