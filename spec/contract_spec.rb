require 'spec_helper'

describe Cfyg::Contract do
  context "solidity contract is a string" do
    it "and compiles solidity contracts" do
      sol_string = "contract test { function multiply(uint a) returns(uint d) {   return a * 7;   } }"
      client = Cfyg::Client.new
      contract = Cfyg::Contract.new(client: client,contract: sol_string).compile
      expect(contract).to start_with "6060604052341561000"
    end
  end
end
