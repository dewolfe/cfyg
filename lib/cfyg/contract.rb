module Cfyg
  class Contract
    attr_accessor :client

    def initialize(**args)
      @sol_path = `which solc`
      raise "unable to locate solc compiler see http://solidity.readthedocs.io/en/develop/installing-solidity.html" if @sol_path.empty?
      @client = args.fetch(:client, Client.new)
    end

    def compile(contract: nil)
      build_from_str(contract) if contract.is_a?(String)
      build_from_file(contract) if contract.is_a?(File)

      client.send(method: 'eth_compileSolidity', params: [contract])
    end


    private
   def build_from_str(contract)
     temp_sol_file = File.open("temp.sol","w"){|file|file.write(contract)}
     resonse = `solc --bin #{}`

   end


  end
end
