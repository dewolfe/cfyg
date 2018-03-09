module Cfyg
  class Response
    attr_accessor :response
    def initialize(**args)
      @response = args.fetch(:response,{})
      parse_response
    end

    private

    def parse_response
      JSON.parse(response.body).each do |k, v|
        instance_variable_set("@#{k}", v)
        self.class.send(:define_method, k) do
          instance_variable_get("@#{k}")
        end
      end
    end
  end
end
