require 'spec_helper'

describe Cfyg::Contract do
  context "solidity contract is a string" do
    it "compiles solidity contracts" do
      sol_string = "contract test { function multiply(uint a) returns(uint d) {   return a * 7;   } }"
      client = Cfyg::Client.new
      contract = Cfyg::Contract.new(client: client,contract: sol_string).compile
      expect(contract).to be an_instance_of(Cfyg::Contract)
    end
  end
end
