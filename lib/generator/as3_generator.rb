# Copyright (c) 2010-2011 Sean Voisen.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'json'
require 'generator/base_generator'

module Crayon
  module Generator


    class AS3Generator < BaseGenerator
      attr_reader :functions
      attr_reader :class_vars

      def initialize(program_name)
        super(program_name)

        reset
      end

      def reset
        @functions = Array.new
        @class_vars = Array.new
      end

      def generate(statements)
        preamble << format(@class_vars.map{|v| v[:declaration]}, 3) << (@class_vars.length > 0 ? "\n\n" : "") << 
          constructor(@class_vars.map{|v| v[:initializer]} + statements) << (@functions.length > 0 ? "\n\n" : "") << 
          format(@functions, 3, "\n\n") << conclusion
      end

      def assign(varprop, value, terminate)
        chain = varprop.split('.')
        var = map_var(chain.first)

        if in_scope?(var)
          "#{varprop} = #{value}" + (terminate ? ";" : "")
        elsif chain.length == 1
          add_to_scope(var)
          if @scope_stack.length == 1
            @class_vars.push({:declaration => "private var #{var}:*;", :initializer => "#{var} = #{value};"})
            # Return empty string in this case so class var is not added inline
            ""
          else
            "var #{var}:* = #{value}" + (terminate ? ";" : "")
          end
        else
          raise SyntaxError, "Access of undefined variable #{var}"
        end
      end

      def compare(op, first, second)
        "#{first} #{map_op(op)} #{second}"
      end

      def function(name, params = [], body = [], closure=false)
        start_scope
        code = format([
                 (closure ? "" : "private ") + "function #{name}(params:Object):*",
                 "{",
                 format(params.map{|name| add_to_scope(name); "var #{name}:* = params.#{name};"}, 1),
                 format(body, 1),
                 "}"
               ])
        end_scope

        return code if closure

        @functions.push(code)

        # Return empty string to avoid function being
        # placed in constructor body
        ""
      end

      def array(items, terminate)
        "[" + items.join(",") + "]" + (terminate ? ";" : "")
      end

      def array_item(index, array)
        "#{array}[#{index}]"
      end

      def var(name)
        map_var(name)
      end

      def unless(condition, statements)
        format([
          "if(!(#{condition}))",
          "{",
          format(statements, 1),
          "}"
        ])
      end

      def if(condition, statements)
        format([
          "if(#{condition})",
          "{",
          format(statements, 1),
          "}"
        ])
      end

      def else(statements)
        format([
          "",
          "else",
          "{",
          format(statements, 1),
          "}"
        ])
      end

      def elseif(condition, statements)
        format([
          "",
          "else if(#{condition})",
          "{",
          format(statements, 1),
          "}"
        ])
      end

      def loop(i, i_start, i_end, inclusive, statements)
        start_scope
        code = format([
          "for(var #{i}:int = #{i_start}; #{i} #{inclusive ? '<=' : '<'} #{i_end}; #{i}++)",
          "{",
          format(statements, 1),
          "}"
        ])
        end_scope
        code
      end

      def while(condition, statements)
        format([
          "while(#{condition})",
          "{",
          format(statements, 1),
          "}"
        ])
      end

      def add_listener(function, event_name)
        "addEventListener(#{map_event(event_name)}, #{function});"
      end

      def remove_listener(function, event_name)
        "removeEventListener(#{map_event(event_name)}, #{function});"
      end

      def call(function_name, arglist, terminate)
        "#{function_name}(#{arglist})" + (terminate ? ";" : "")
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

      def boolean(value)
        value
      end

      private

        def preamble
          format([
            "package",
            "{",
            "  import flash.geom.Point;",
            "  import flash.events.Event;",
            "  import flash.events.MouseEvent;",
            "",
            "  import org.voisen.crayon.CrayonProgram;",
            "",
            "  [SWF(width='800', height='600', frameRate='30')]",
            "  public class #{program_name} extends CrayonProgram",
            "  {",
            ""
         ])      
        end

        def constructor(statements)
          start_scope
          code = format([
            "public function #{program_name}()",
            "{",
            format(statements, 1),
            "}",
          ], 3)
          end_scope
          code
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
          when "=" then "=="
          else op
          end
        end

        def map_event(event_name)
          case event_name
          when "frame" then "Event.ENTER_FRAME"
          when "mouse up" then "MouseEvent.MOUSE_UP"
          when "mouse down" then "MouseEvent.MOUSE_DOWN"
          else event_name
          end
        end

        def map_var(var)
          case var
          when "x" then "__x"
          when "y" then "__y"
          else var
          end
        end
    end

  end
end
