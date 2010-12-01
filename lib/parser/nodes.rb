class String
  def codegen(generator)
    self
  end
end

class ::Treetop::Runtime::SyntaxNode
  def value
    text_value
  end

  def codegen(context)
    raise "Method codegen not defined in #{self}"
  end
end

module Crayon
  module Parser
    Node = Treetop::Runtime::SyntaxNode

    class Script < Node
      def compile(generator)
        generator.generate(expressions.map{|e| e.codegen(generator).last})
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

    class Loop < Node
      def codegen(generator)
        generator.loop(count.codegen(generator), expressions.map{|e| e.codegen(generator).last})
      end
    end

    class Variable < Node
      def codegen(generator)
        generator.var(value)
      end
    end

    class List < Node
      def codegen(generator)
        generator.array(items.map{|i| i.codegen(generator).last})
      end
    end

    class Function < Node
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
          # TODO: This shouldn't be empty, so there is a problem with the grammar
          next if var.empty? or val.empty?
          named_args[var.codegen(generator)] = val.codegen(generator).last
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
end
