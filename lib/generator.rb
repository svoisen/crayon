module Crayon
  class Generator
    def initialize(name)
      @name = name
      @indent = 0
    end

    def format(code, indent=0, nested=false, append_newline=false)
      prefix = ''
      indent.times {prefix << ' '} 
      code.map{|s| prefix + (nested ? s.lstrip : s)}.join("\n") << (append_newline ? "\n" : '')
    end
  end
end
