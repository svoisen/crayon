require 'lib/generator'

module Crayon
  class ASMGenerator < Generator
    def preamble(node)
      "function main():*\n{\n"
    end

    def assign(name, value)
      "\tgetlocal0\n#{value}\tsetproperty\t#{name}\n"
    end

    def new_number(value)
      "\tpushbyte\t#{value.to_s}\n"
    end

    def load_var(name)
      "\tgetlocal0\n\tgetproperty\t#{name}\n"
    end

    def call(function_name, *arguments)
      asm =  "\tgetlocal0\n"
      asm << "\tfindpropstrict\t{package}::#{function_name}\n"
      arguments.each {|arg| asm << "#{arg}"}
      asm << "\tcallpropvoid\t#{function_name}\t#{arguments.length}\n"
    end

    def calculate(operator, operand1, operand2)
      asm = operand1 << operand2
      asm << case operator
      when "+" then "\tadd\n"
      when "-" then "\tsub\n"
      when "*" then "\tmul\n"
      when "\\" then "\tdiv\n"
      else ""
      end
    end

    def finish
      "\treturnvoid\n}"
    end
  end
end
