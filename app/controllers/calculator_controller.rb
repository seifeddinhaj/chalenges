class CalculatorController < ApplicationController

    def compute
        # I used request.query_string and not params["expression"] because when i put the operator "+" in the expression it doesn't appear
        expression = request.query_string[request.query_string.index("=")+1..-1]
        if !expression.present? || !expression.include?("+") && !expression.include?("-") && !expression.include?("*") && !expression.include?("/")
            render json: {result: "Please put an arithmetic expression!", expression: expression}, status: 422
        else
            begin
                res = eval(   expression   )
            rescue Exception => exc
                res = "bad expression #{exc.message}"
            end
            if  res.class != Integer
                render json: {result: res, expression: expression}, status: 406
            else
                render json: {expression: expression, result: res}
            end
        end
    end
end
