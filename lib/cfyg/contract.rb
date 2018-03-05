module Cfyg
  class Contract
    attr_accessor :client

    def initialize(**args)
      @sol_path = `which solc`
      raise "unable to locate solc compiler" if @sol_path.empty?
      @client = args.fetch(:client, Client.new)
    end

    def compile(contract: nil)
      client.send(method: 'eth_compileSolidity', params: [contract])
    end


    private


  end
end
