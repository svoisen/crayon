class String
  def codegen(generator)
    self
  end

  def value
    self
  end
end

class ::Treetop::Runtime::SyntaxNode
  def value
    text_value
  end

  def codegen(context)
    raise "Method codegen not defined in #{self} : #{value}"
  end
end

module Crayon
  module Parser
    Node = Treetop::Runtime::SyntaxNode

    class Script < Node
      def compile(generator)
        generator.generate(statements.map{|s| s.codegen(generator)})
      end
    end

    class Object < Node
      def codegen(generator)
        object.codegen(generator)
      end
    end

    class Call < Node
      def codegen(generator)
        generator.call function.value, arglist.codegen(generator)
      end
    end

    class Assignment < Node
      def codegen(generator)
        generator.assign varprop.codegen(generator), expression.codegen(generator)
      end
    end

    class Comparison < Node
      def codegen(generator)
        generator.compare compareop.value, object.codegen(generator), expression.codegen(generator) 
      end
    end

    class Equation < Node
      def codegen(generator)
        generator.calculate mathop.value, object.codegen(generator), expression.codegen(generator)
      end
    end

    class CountLoop < Node
      def codegen(generator)
        generator.loop((!defined? counter or counter.varprop.empty?) ? "__i" : counter.varprop.codegen(generator),
                       (!defined? i_start or i_start.empty?) ? 0 : i_start.codegen(generator), 
                       i_end.codegen(generator), 
                       (defined? i_start and !i_start.empty?), 
                       statements.map{|s| s.codegen(generator)})
      end
    end

    class Property < Node
      def codegen(generator)
        generator.property(property.value, object.codegen(generator))
      end
    end

    class WhileLoop < Node
      def codegen(generator)
        generator.while(condition.codegen(generator), statements.map{|s| s.codegen(generator)})
      end
    end

    class Variable < Node
      def codegen(generator)
        generator.var(identifier.value)
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
        generator.function name.codegen(generator), args.map{|a| a.value}, statements.map{|s| s.codegen(generator)}
      end
    end

    class If < Node
      def codegen(generator)
        generator.if condition.codegen(generator), statements.map{|s| s.codegen(generator)}
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
        args.each do |id,val|
          # TODO: This shouldn't be empty, so there is a problem with the grammar
          next if id.empty? or val.empty?
          named_args[id.value] = val.codegen(generator)
        end
        generator.arglist(named_args)
      end
    end

    class Number < Node
      def codegen(generator)
        generator.number(value)
      end
    end

    class Comment < Node
      def codegen(generator)
        ""
      end
    end
  end
end
