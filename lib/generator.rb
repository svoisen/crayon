module Crayon
  class Generator
    attr_reader :program_name

    def initialize(program_name)
      @tab_width = 2
      @program_name = program_name
      @vars_in_scope = []
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

    def add_to_scope(var)
      @vars_in_scope.push(var)
    end

    def in_scope?(var)
      @vars_in_scope.include?(var)
    end

    def reset_scope
      @vars_in_scope = []
    end
  end
end
