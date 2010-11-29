require 'json'
require 'lib/generator'

module Crayon
  class AS3Generator < Generator
    def generate(expressions)
      preamble << format(expressions, 3) << conclusion
    end

    def preamble
      format([
        "package",
        "{",
        "  import flash.geom.Point;",
        "",
        "  import org.voisen.crayon.CrayonProgram;",
        "",
        "  [SWF(width='800', height='600', frameRate='30')]",
        "  public class #{program_name} extends CrayonProgram",
        "  {",
        "    public function #{program_name}()",
        "    {",
        ""
      ])      
    end

    def assign(name, value)
      if in_scope?(name)
        "#{name} = #{value};"
      else
        add_to_scope(name)
        "var #{name}:* = #{value};"
      end
    end

    def function(name)
    end

    def var(name)
      name
    end

    def loop(count, expressions)
      format([
        "for(var __i:int = 0; __i < #{count}; __i++)",
        "{",
        format(expressions, 1),
        "}"
      ])
    end

    def call(function_name, arglist)
      "#{function_name}(#{arglist});"
    end

    def arglist(args)
      substitutions = {'"' => '', '\"' => '"'}
      args.to_json.gsub(/\"|\\\"/){|match| substitutions[match]}
    end

    def calculate(operator, operand1, operand2)
      "#{operand1} #{operator} #{operand2}"
    end

    def array
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
