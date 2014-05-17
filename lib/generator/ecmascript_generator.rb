# encoding: UTF-8

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

      PREDEFINED_CLASS_VARS = %w[canvas]

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

      def assign(varprops, value, terminate)
        lines = []
        varprops.each do |varprop|
          chain = varprop.split('.')
          var = map_var(chain.first)

          if class_var_exists?(var) or var_exists?(var)
            lines.push "#{varprop} = #{value}" + (terminate ? ";" : "")

          elsif chain.length == 1
            # Constructor will have no scope, all variables in constructor assumed to
            # be class variables
            if @current_scope.nil?
              @class_vars.push declare_class_var(var, value)
            else
              add_to_scope(var)
              lines.push declare_local_var(var, value)
            end
          else
            raise SyntaxError, "Access of undefined variable #{var}"
          end
        end
        lines.join("\n")
      end

      def compare(op, first, second, parenthesize)
        wrap "#{first} #{map_op(op)} #{second}", parenthesize
      end

      def calculate(operator, operand1, operand2, parenthesize)
        wrap "#{operand1} #{operator} #{operand2}", parenthesize
      end

      def property(property, object, parenthesize)
        wrap "#{object}.#{property}", parenthesize
      end

      def method(object, call, parenthesize)
        "#{object}.#{call}"
      end

      def number(value, parenthesize)
        wrap value.to_s, parenthesize
      end

      def string(value, parenthesize)
        wrap "\"#{value}\"", parenthesize
      end

      def boolean(value)
        wrap value, parenthesize
      end

      def arglist(args)
        substitutions = {'"' => '', '\"' => '"'}
        args.to_json.gsub(/\"|\\\"/){|match| substitutions[match]}
      end

      def array(items, terminate, parenthesize)
        wrap("new List([" + items.join(",") + "])", parenthesize) + (terminate ? ";" : "")
      end

      def array_item(index, array, parenthesize)
        wrap "#{array}._collection[#{index}]", parenthesize
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

      def while(condition, statements)
        format([
          "while(#{condition})",
          "{",
          format(statements, 1),
          "}"
        ])
      end

      private

        def var_exists?(name)
          true if name == "this" or in_ancestral_scope?(name)
        end

        def class_var_exists?(name)
          true if predefined_class_var?(name) or @class_vars.map{|v| v[:name]}.include?(name)
        end

        def predefined_class_var?(name)
          PREDEFINED_CLASS_VARS.include?(name)
        end

        def map_var(var)
          var
        end

        def wrap(code, parenthesize)
          if parenthesize
            "(" + code + ")"
          else
            code
          end
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
