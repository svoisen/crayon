module Crayon
  class Generator
    def initialize(name)
      @name = name
      @indent = 0
      @vars_in_scope = []
    end

    def format(code, indent=0, append_with='', join_with="\n")
      prefix = ''
      indent.times {prefix << ' '} 
      code.map{|line| prefix + line}.join(join_with) << append_with
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
