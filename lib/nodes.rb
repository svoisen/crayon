module Crayon
  class ::Treetop::Runtime::SyntaxNode
    def value
      text_value
    end

    def codegen(context)
      raise "Method codegen not defined in #{self}"
    end
  end
  Node = Treetop::Runtime::SyntaxNode

  class Script < Node
    def compile(generator)
      code = generator.preamble(self)
      expressions.each do |e| 
        e.codegen(generator).each do |s|
          code << s unless s.nil?
        end
      end
      code << generator.conclusion
    end
  end

  class Expression < Node
    def codegen(generator)
      statements.map {|s| s.codegen(generator)}
    end
  end

  class Call < Node
    def codegen(generator)
      generator.call function.value, arglist.codegen(generator)
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
      generator.var(value)
    end
  end

  class String < Node
    def codegen(generator)
      generator.string(value)
    end
  end

  class Arglist < Node
    def codegen(generator)
      named_args = Hash.new
      args.each do |var,val|
        named_args[var.codegen(generator)] = val.codegen(generator)
      end
      generator.arglist(named_args)
    end
  end

  class Number < Node
    def codegen(generator)
      generator.number(value)
    end
  end
end
