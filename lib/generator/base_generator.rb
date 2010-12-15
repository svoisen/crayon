module Crayon
  module Generator

    class BaseGenerator
      attr_reader :program_name

      def initialize(program_name)
        @tab_width = 2
        @program_name = program_name
        @scope_stack = Array.new
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
            block.split("\n").map{|line| prefix + line}.join("\n")
          end
        end

        def start_scope
          @current_scope = Array.new
          @scope_stack.push(@current_scope)
        end

        def end_scope
          @scope_stack.pop()
        end

        def add_to_scope(var)
          @current_scope.push(var)
        end

        def in_scope?(var)
          @current_scope.include?(var)
        end
    end

  end
end
