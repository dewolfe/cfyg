require 'spec_helper'

describe Cfyg::Contract do

  before(:all) do
    @client = Cfyg::Client.new
    @valid_sol_string = "contract test { function multiply(uint a) returns(uint d) {   return a * 7;   } }"
    @invalid_sol_string = "this is not a good contract"
  end
  context "solidity contract is a string" do
    it "and it raises an error when passed an invalid contract" do
      expect {Cfyg::Contract.new(client: @client, contract: @invalid_sol_string).compile}.to raise_error
    end

    it "and it compiles solidity contracts" do
      contract = Cfyg::Contract.new(client: @client,contract: @valid_sol_string).compile
      expect(contract).to start_with "6060604052341561000"
    end

    it "and it deploys solidity contracts to the blockchain" do
      res = Cfyg::Contract.new(client: @client, contract: @valid_sol_string).deploy
      except(res.response.code).to eq("200")

    end
  end
end
