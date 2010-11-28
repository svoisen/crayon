module Crayon
  class Generator
    def initialize(name)
      @name = name
      @indent = 6
    end

    def format(code, indent=0, append_newline=false)
      prefix = ''
      indent.times {prefix << ' '} 
      prefix << code.join("\n") << (append_newline ? "\n" : '')
    end
  end
end
