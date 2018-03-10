module Cfyg
  class Contract
    require 'tempfile'
    require 'open3'
    attr_reader :to, :gas, :gas_price, :value
    attr_accessor :client, :sol_path, :contract, :binary, :from

    def initialize(**args)
      @sol_path = `which solc`.chop
      raise 'unable to locate solc compiler see http://solidity.readthedocs.io/en/develop/installing-solidity.html' if @sol_path.empty?
      @client = args.fetch(:client, Client.new)
      @contract = args.fetch(:contract, '')
      @from = args[:from]
      @to = args[:to]
      @gas = args[:gas]
      @gas_price = args[:gas_price]
      @value = args[:value]
    end

    def compile
      build_from_str if contract.is_a?(String)
    end

    def deploy
      client.send(method: :eth_sendTransaction, params: [deploy_params])
    end

    private

    def deploy_params
      { from: from, to: to, gas: hex_value(gas), gasPrice: hex_value(gas_price),
        value: hex_value(value), data: "0x#{compile}" }
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

    def hex_value(n)
      n&.to_s(16)&.prepend('0x')
    end

    def parse_response(result)
      stout, sterr, _status = result
      raise "error compiling contract #{sterr[/Error.*/]}" if sterr.include?('Error')
      stout.split("\n")[3]
    end
  end
end
