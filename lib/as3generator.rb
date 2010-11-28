require 'json'
require 'lib/generator'

module Crayon
  class AS3Generator < Generator
    def preamble(node)
      # Indent level after last line in preamble
      @indent = 6

      format([
        "package",
        "{",
        "  import flash.geom.Point;",
        "",
        "  import org.voisen.crayon.CrayonProgram;",
        "",
        "  public class #{@name} extends CrayonProgram",
        "  {",
        "    public function #{@name}()",
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

    def loop(count, expressions)
      format([
        "for(var __i:int = 0; __i < #{count}; __i++)",
        "{",
        format(expressions, 2, true),
        "}"
      ], @indent)
    end

    def call(function_name, arglist)
      format([
        "#{function_name}(#{arglist});"
      ], @indent, false, true)
    end

    def arglist(args)
      substitutions = {'"' => '', '\"' => '"'}
      args.to_json.gsub(/\"|\\\"/){|match| substitutions[match]}
    end

    def calculate(operator, operand1, operand2)
      "#{operand1} #{operator} #{operand2}"
    end

    def point(x, y)
      "new Point(#{x}, #{y})"
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
