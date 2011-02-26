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
require 'generator/ecmascript_generator'

module Crayon
  module Generator

    class AS3Generator < ECMAScriptGenerator
      def initialize(program_name)
        super(program_name)
      end

      def generate(statements)
        preamble << format(@class_vars.map{|v| v[:declaration]}, 3) << (@class_vars.length > 0 ? "\n\n" : "") << 
          constructor(@class_vars.map{|v| v[:initializer]} + statements) << (@functions.length > 0 ? "\n\n" : "") << 
          format(@functions, 3, "\n\n") << conclusion
      end

      def function(name, params = [], body = [], closure = false)
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

      def class_var(var, value)
        {:declaration => "private var #{var}:*;", :initializer => "#{var} = #{value};"}
      end

      def local_var(var, value)
        "var #{var}:* = #{value};"
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
