require 'json'
require 'lib/generator'

module Crayon
  class AS3Generator < Generator
    def preamble(node)
      @indent = 6
      format([
        "package",
        "{",
        "  public class Crayon extends CrayonProgram",
        "  {",
        "    public function Crayon()",
        "    {",
        ""
      ])      
    end

    def assign(name, value)
      format([
        "var #{name} = #{value};"
      ], @indent)
    end

    def var(name)
      name
    end

    def call(function_name, arglist)
      format([
        "callWithNamedParams(#{function_name}, #{arglist});"
      ], @indent)
    end

    def arglist(args)
      args.to_json
    end

    def calculate(operator, operand1, operand2)
      "#{operand1} #{operator} #{operand2}"
    end

    def number(value)
      value.to_s
    end

    def string(value)
      "\"#{value}\""
    end

    def conclusion
      format([
        "",
        "    }",
        "  }",
        "}"
      ])
    end
  end
end
