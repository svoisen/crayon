require 'json'
require 'lib/generator'

module Crayon
  class AS3Generator < Generator
    def preamble
      # Indent level after last line in preamble
      @indent = 6

      format([
        "package",
        "{",
        "  import flash.geom.Point;",
        "",
        "  import org.voisen.crayon.CrayonProgram;",
        "",
        "  [SWF(width='800', height='600', frameRate='30')]",
        "  public class #{@name} extends CrayonProgram",
        "  {",
        "    public function #{@name}()",
        "    {",
      ], 0, "\n" )      
    end

    def assign(name, value)
      output = if( in_scope?(name) )
                 "#{name} = #{value};"
               else
                 add_to_scope(name)
                 "var #{name}:* = #{value};"
               end
      
      format([output], @indent, "\n")
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
        format(expressions, 2, "", ""),
        "}"
      ], @indent, "\n")
    end

    def call(function_name, arglist)
      format([
        "#{function_name}(#{arglist});"
      ], @indent, "\n")
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
        "    }",
        "  }",
        "}"
      ])
    end
  end
end
