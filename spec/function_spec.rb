require 'spec_helper'

describe Cfyg::Function do
  it 'initializes with a function string' do
    function_string = 'foo(uint b, bool c)'
    function = Cfyg::Function.new(function: function_string)
    expect(function.abi).to eq('0xbfc8cf02')
  end

end
