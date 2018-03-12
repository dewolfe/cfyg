module Cfgy
  class Invoke
    #a.scan(/(?<=function).*?\)/)

    attr_accessor :contract, :method, :args

    def initalize(contract: , method: , args: [])
      @contact = contract
      @method = method
      @args = args
    end

    private

    def method_sig
      s = contract.scan(/(?<=function).*?\)/)
      s.each do |m|
        method_name = m.split('(').first.gsub(/\s+/,'')
        signature = SOLIDIARY_TYPES.inject([]){|sig,type|sig << m[/\b#{type}\b/] }.compact
      end
      Digest:SHA3(meth)
    end


  end
end
