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
        generator.generate(expressions.map{|e| e.codegen(generator)})
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
        generator.assign var.value, expression.codegen(generator)
      end
    end

    class Comparison < Node
      def codegen(generator)
        generator.compare op.value, object.codegen(generator), expression.codegen(generator) 
      end
    end

    class Equation < Node
      def codegen(generator)
        generator.calculate op.value, object.codegen(generator), expression.codegen(generator)
      end
    end

    class CountLoop < Node
      def codegen(generator)
        generator.loop(var.empty? ? "__i" : var.codegen(generator), 
                       i_start.empty? ? 0 : i_start.codegen(generator), 
                       i_end.codegen(generator), 
                       !i_start.empty?, 
                       expressions.map{|e| e.codegen(generator)})
      end
    end

    class WhileLoop < Node
      def codegen(generator)
        generator.while(condition.codegen(generator), expressions.map{|e| e.codegen(generator)})
      end
    end

    class Variable < Node
      def codegen(generator)
        generator.var(value)
      end
    end

    class List < Node
      def codegen(generator)
        generator.array(items.map{|i| i.codegen(generator)})
      end
    end

    class ListItem < Node
      def codegen(generator)
        generator.array_item(item.codegen(generator), list.codegen(generator))
      end
    end

    class Function < Node
      def codegen(generator)
        generator.function name.codegen(generator), args.map{|a| a.codegen(generator)}, expressions.map{|e| e.codegen(generator)}
      end
    end

    class If < Node
      def codegen(generator)
        generator.if condition.codegen(generator), expressions.map{|e| e.codegen(generator)}
      end
    end

    class ElseIf < Node
    end

    class Else < Node
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
end
