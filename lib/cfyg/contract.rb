module Cfyg

  class Contract
    require 'tempfile'
    attr_accessor :client, :sol_path, :contract

    def initialize(**args)
      @sol_path = `which solc`.chop
      raise 'unable to locate solc compiler see http://solidity.readthedocs.io/en/develop/installing-solidity.html' if @sol_path.empty?
      @client = args.fetch(:client, Client.new)
      @contract = args.fetch(:contract,"")
    end

    def compile
      build_from_str if contract.is_a?(String)
    end

    private

    def build_from_str
      parse_response(`#{sol_path} --bin #{temp_file}`)
    end

    def temp_file
      temp_sol_file = Tempfile.new("temp.sol")
      temp_sol_file.write(contract)
      temp_sol_file.close
      temp_sol_file.path
    end

    def parse_response(response)
      response.split("\n").last
    end


  end
end
