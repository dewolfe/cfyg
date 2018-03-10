require 'spec_helper'

describe Cfyg::Contract do

  before(:all) do
    @client = Cfyg::Client.new
    @valid_sol_string = "contract test { function multiply(uint a) returns(uint d) {   return a * 7;   } }"
    @invalid_sol_string = "this is not a good contract"
  end

  context "solidity contract is a string" do
    it "and it raises an error when passed an invalid contract" do
      expect {Cfyg::Contract.new(client: @client,
                                 contract: @invalid_sol_string).compile}.to raise_error
    end

    it "and it compiles solidity contracts" do
      contract = Cfyg::Contract.new(client: @client,
                                    contract: @valid_sol_string).compile
      expect(contract).to start_with "6060604052341561000"
    end

    it "and it deploys solidity contracts to the blockchain" do
      res = Cfyg::Contract.new(client: @client, contract: @valid_sol_string).deploy
      expect(res.response.code).to eq("200")
    end

    it "and it sets gas, gas_price and vale to their hex values" do
      contract = Cfyg::Contract.new(client: @client, contact: @valid_sol_string,
                                    gas: 2000, gas_price: 3000, value: 2000)
      expect(contract.send(:deploy_params)).to eq ({:from=>nil, :to=>nil, :gas=>"0x7d0",
                                                    :gasPrice=>"0xbb8", :value=>"0x7d0",
                                                    :data=>"0x"})
    end
  end
end
