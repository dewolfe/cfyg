require 'spec_helper'

describe Cfyg::Contract do

  before(:all) do
    @client = Cfyg::Client.new
  end
  context "solidity contract is a string" do
    it "and it raises an error when passed an invalid contract" do
      sol_string = "this is not a good contract"
      expect {Cfyg::Contract.new(client: @client, contract: sol_string).compile}.to raise_error
    end

    it "and compiles solidity contracts" do
      sol_string = "contract test { function multiply(uint a) returns(uint d) {   return a * 7;   } }"
      contract = Cfyg::Contract.new(client: @client,contract: sol_string).compile
      expect(contract).to start_with "6060604052341561000"
    end
  end
end
