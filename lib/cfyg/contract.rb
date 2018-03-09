module Cfyg
  class Contract
    require 'tempfile'
    require 'open3'
    attr_reader  :to, :gas, :gas_price, :value
    attr_accessor :client, :sol_path, :contract, :binary, :from

    def initialize(**args)
      @sol_path = `which solc`.chop
      raise 'unable to locate solc compiler see http://solidity.readthedocs.io/en/develop/installing-solidity.html' if @sol_path.empty?
      @client = args.fetch(:client, Client.new)
      @contract = args.fetch(:contract, '')
      @from = args[:from]
      @to = args.fetch(:to, nil )
      @gas =args.fetch(:gas, nil )
      @gas_price = args.fetch(:gas_price, nil )
      @value = args.fetch(:value,nil)

    end

    def compile
      build_from_str if contract.is_a?(String)
    end

    def deploy
      binding.pry
      client.send(method: :eth_sendTransaction ,params: [deploy_params])
    end

    private

    def deploy_params
      {from: from, to: to, gas: gas, gasPrice: gas_price, value: value, data: "0x#{compile}"}
    end

    def build_from_str
      parse_response(Open3.capture3("#{sol_path} --bin #{temp_file}"))
    end

    def temp_file
      temp_sol_file = Tempfile.new('temp.sol')
      temp_sol_file.write(contract)
      temp_sol_file.close
      temp_sol_file.path
    end

    def parse_response(result)
      stout, sterr, status = result
      raise "error compiling contract #{sterr[/Error.*/]}" if sterr.include?("Error")
      stout.split("\n")[3]
    end
  end
end
