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

    class ECMAScriptGenerator < BaseGenerator
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
        raise Error, "Do not generate from this class. Use AS3 or JS subclass generators."
      end

      def assign(varprop, value, terminate)
        chain = varprop.split('.')
        var = map_var(chain.first)

        if in_scope?(var)
          "#{varprop} = #{value}" + (terminate ? ";" : "")
        elsif chain.length == 1
          add_to_scope(var)
          if @scope_stack.length == 1
            @class_vars.push(class_var(var, value))
            # Return empty string in this case so class var is not added inline
            ""
          else
            local_var(var, value)
          end
        else
          raise SyntaxError, "Access of undefined variable #{var}"
        end
      end
      def compare(op, first, second)
        "#{first} #{map_op(op)} #{second}"
      end

      def call(function_name, arglist, terminate)
        "#{function_name}(#{arglist})" + (terminate ? ";" : "")
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

      def arglist(args)
        substitutions = {'"' => '', '\"' => '"'}
        args.to_json.gsub(/\"|\\\"/){|match| substitutions[match]}
      end

      def array(items, terminate)
        "[" + items.join(",") + "]" + (terminate ? ";" : "")
      end

      def array_item(index, array)
        "#{array}[#{index}]"
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

      def var(name)
        map_var(name)
      end

      private

        def map_var(name)
          name
        end

        def map_op(op)
          case op
          when "≤" then "<="
          when "≥" then ">="
          when "=" then "=="
          else op
          end
        end

    end

  end
end
