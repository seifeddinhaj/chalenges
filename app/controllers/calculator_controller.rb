class CalculatorController < ApplicationController

    def compute
        begin
            # I used request.query_string and not params["expression"] because when i put the operator "+" in the expression it doesn't appear
            expression = request.query_string[request.query_string.index("=")+1..-1]
            res = eval(   expression   )
        rescue Exception => exc
            res = "bad expression #{exc.message}"
        end
        if res == "bad expression" || res.class != Integer
            render json: {result: res, expression: expression}, status: 406
        else
            render json: {result: res, expression: expression}
        end

    end
end
