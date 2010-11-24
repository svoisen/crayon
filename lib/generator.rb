module Crayon
  class Generator
    def format(code, indent=0)
      prefix = ''
      indent.times {prefix << ' '} 
      prefix << code.join("\n")
    end
  end
end
