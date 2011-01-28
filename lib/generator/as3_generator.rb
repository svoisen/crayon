require 'json'
require 'generator/base_generator'

module Crayon
  module Generator

    class SyntaxError < RuntimeError; end

    class AS3Generator < BaseGenerator
      def initialize(program_name)
        super(program_name)

        @functions = Array.new
      end

      def generate(expressions)
        preamble << constructor(expressions) << (@functions.length > 0 ? "\n\n" : "") << format(@functions, 3) << conclusion
      end

      def assign(varprop, value)
        chain = varprop.split('.')
        var = chain.first

        if in_scope?(var)
          "#{varprop} = #{value}"
        elsif chain.length == 1
          add_to_scope(var)
          "var #{var}:* = #{value}"
        else
          raise SyntaxError, "Access of undefined variable #{var}"
        end
      end

      def compare(op, first, second)
        "#{first} #{map_op(op)} #{second}"
      end

      def function(name, params = [], body = [])
        start_scope
        @functions.push(
          format([
            "private function #{name}(params:Object):void",
            "{",
            format(params.map{|name| add_to_scope(name); "var #{name}:* = params.#{name};"}, 1),
            format(body, 1),
            "}"
          ])
        )
        end_scope

        # Return empty string to avoid function being
        # placed in constructor body
        return ""
      end

      def array(items)
        "[" + items.join(",") + "]"
      end

      def array_item(index, array)
        "#{array}[#{index}]"
      end

      def var(name)
        name
      end

      def if(condition, expressions)
        format([
          "if(#{condition})",
          "{",
          format(expressions, 1),
          "}"
        ])
      end

      def loop(i, i_start, i_end, inclusive, expressions)
        format([
          "for(var #{i}:int = #{i_start}; #{i} #{inclusive ? '<=' : '<'} #{i_end}; #{i}++)",
          "{",
          format(expressions, 1),
          "}"
        ])
      end

      def while(condition, expressions)
        format([
          "while(#{condition})",
          "{",
          format(expressions, 1),
          "}"
        ])
      end

      def call(function_name, arglist)
        "#{function_name}(#{arglist})"
      end

      def arglist(args)
        substitutions = {'"' => '', '\"' => '"'}
        args.to_json.gsub(/\"|\\\"/){|match| substitutions[match]}
      end

      def calculate(operator, operand1, operand2)
        "#{operand1} #{operator} #{operand2}"
      end

      def property(property, object)
        "#{object}.#{property}"
      end

      def number(value)
        value.to_s
      end

      def string(value)
        "\"#{value}\""
      end

      private

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
            ""
         ])      
        end

        def constructor(expressions)
          format([
            "public function #{program_name}()",
            "{",
            format(expressions, 1),
            "}",
          ], 3)
        end

        def conclusion
          format([
            "",
            "  }",
            "}"
          ])
        end

        def map_op(op)
          case op
          when "≤" then "<="
          when "≥" then ">="
          else op
          end
        end
    end

  end
end
