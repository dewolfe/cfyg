module Cfyg
  class Function
    require 'digest/sha3'
    TYPES = %w(bool int uint fixed ufixed address byte string)
    attr_accessor :function

    def initialize(function:)
      @function = function
    end

    def abi
      generate_abi
    end

    private

    def generate_abi
      ms = extract_method_name + extract_method_sig
      Digest::SHA3.hexdigest(ms, 256)[0..7].prepend('0x')
    end

    def extract_method_name
      function.split('(').first.gsub(/\s+/, '')
    end

    def extract_method_sig
      sig = TYPES.inject([]) { |array, type| array << function[/\b#{type}\b/] }.
        compact.reverse
      "(#{sig.join(',')})"
    end
  end
end
