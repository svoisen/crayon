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

module Crayon
  module Generator

    class SyntaxError < RuntimeError; end

    class BaseGenerator
      attr_reader :program_name

      def initialize(program_name)
        @tab_width = 2
        @program_name = program_name
        @scope_stack = Array.new
      end

      def start_scope
        @current_scope = Array.new
        @scope_stack.push(@current_scope)
      end

      def end_scope
        @scope_stack.pop()
        @current_scope = @scope_stack.last
      end

      private

        def format(code, level=0, glue="\n", appendix='')
          indent(code, level).join(glue) << appendix
        end

        # Indents an array of code blocks to a specific indentation
        # level, where level is the number of tabs (as spaces) to 
        # indent
        def indent(code, level=0)
          prefix = ''
          (level * @tab_width).times {prefix << ' '}
          code.map do |block| 
            block.split("\n").map{|line| line.length == 0 ? nil : prefix + line}.compact.join("\n")
          end
        end

        def add_to_scope(var)
          #start_scope if @current_scope.nil?
          @current_scope.push(var)
        end

        def in_scope?(var)
          @current_scope.nil? ? false : @current_scope.include?(var)
        end

        def in_ancestral_scope?(var)
          @scope_stack.reverse.each do |scope|
            return true if !scope.nil? and scope.include?(var)
          end

          false
        end 
    end

  end
end
