module Crayon
  class ::Treetop::Runtime::SyntaxNode
    def value
      text_value
    end

    def codegen(context)
    end
  end
  Node = Treetop::Runtime::SyntaxNode

  class Script < Node
    def compile(generator)
      asm = generator.preamble(self)
      expressions.each do |e| 
        e.codegen(generator).each do |s|
          asm << s unless s.nil?
        end
      end
      asm << generator.finish
    end
  end

  class Expression < Node
    def codegen(generator)
      statements.map {|s| s.codegen(generator)}
    end
  end

  class Call < Node
    def codegen(generator)
      argument_values = arglist.args.map {|arg| arg.codegen(generator)}
      generator.call function.value, *argument_values
    end
  end

  class Assignment < Node
    def codegen(generator)
      generator.assign var.value, expression.codegen(generator).last
    end
  end

  class Equation < Node
    def codegen(generator)
      generator.calculate op.value, object.codegen(generator), expression.codegen(generator).last
    end
  end

  class Variable < Node
    def codegen(generator)
      generator.load_var(value)
    end
  end

  class Number < Node
    def codegen(generator)
      generator.new_number(value)
    end
  end
end
