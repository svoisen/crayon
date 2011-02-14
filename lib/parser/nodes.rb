# This file contains definitions of how to generate code from the various
# nodes of the parse tree. Each node in the tree is its own class, which
# subclasses the Treetop Node class. Each of these subclasses defines a
# method "codegen" which calls a generator method to generate the code
# for that particular node.

# In case we attempt to generate code for a string, just print the string
# instead.
class String
  def codegen(generator, terminate=false)
    self
  end

  def value
    self
  end
end

class ::Treetop::Runtime::SyntaxNode
  # Return the value of the node
  def value
    text_value
  end

  # Generate code for this node. The terminate parameter should
  # be true if this is a statement that should be terminated by
  # the generator (i.e. a semi-colon for C-style languages).
  def codegen(context, terminate=false)
    raise "Method codegen not defined in #{self} : #{value}"
  end
end

module Crayon
  module Parser
    Node = Treetop::Runtime::SyntaxNode

    class Script < Node
      def compile(generator)
        generator.generate(statements.map{|s| s.codegen(generator, true)})
      end
    end

    class Object < Node
      def codegen(generator, terminate=false)
        object.codegen(generator)
      end
    end

    class Call < Node
      def codegen(generator, terminate=false)
        generator.call function.value, arglist.codegen(generator), terminate
      end
    end

    class InlineCall < Node
      def codegen(generator, terminate=false)
        generator.call function.value, inline_arglist.codegen(generator), terminate
      end
    end

    class Assignment < Node
      def codegen(generator, terminate=false)
        generator.assign varprop.codegen(generator), expression.codegen(generator), terminate
      end
    end

    class Comparison < Node
      def codegen(generator, terminate=false)
        generator.compare compareop.value, object.codegen(generator), expression.codegen(generator) 
      end
    end

    class Equation < Node
      def codegen(generator, terminate=false)
        generator.calculate mathop.value, object.codegen(generator), expression.codegen(generator)
      end
    end

    class CountLoop < Node
      def codegen(generator, terminate=false)
        generator.loop((!defined? counter or !defined? counter.varprop) ? "__i" : counter.varprop.codegen(generator),
                       (!defined? i_start or i_start.empty?) ? 0 : i_start.codegen(generator), 
                       i_end.codegen(generator), 
                       (defined? i_start and !i_start.empty?), 
                       statements.map{|s| s.codegen(generator)})
      end
    end

    class Property < Node
      def codegen(generator, terminate=false)
        generator.property property.value, object.codegen(generator)
      end
    end

    class WhileLoop < Node
      def codegen(generator, terminate=false)
        generator.while condition.codegen(generator), statements.map{|s| s.codegen(generator)}
      end
    end

    class Variable < Node
      def codegen(generator, terminate=false)
        generator.var identifier.value
      end
    end

    class List < Node
      def codegen(generator, terminate=false)
        generator.array items.map{|i| i.codegen(generator)}, terminate
      end
    end

    class ListItem < Node
      def codegen(generator, terminate=false)
        generator.array_item item.codegen(generator), list.codegen(generator)
      end
    end

    class Function < Node
      def codegen(generator, terminate=false)
        generator.function name.codegen(generator), args.map{|a| a.value}, statements.map{|s| s.codegen(generator)}
      end
    end

    class If < Node
      def codegen(generator, terminate=false)
        code = generator.if condition.codegen(generator), statements.map{|s| s.codegen(generator, true)}
        if defined? els and !els.empty?
          code += els.codegen(generator)
        end
        if defined? elseif and !elseif.empty?
          code += elseif.codegen(generator)
        end
        code
      end
    end

    class ElseIf < Node
      def codegen(generator, terminate=false)
        code = generator.elseif condition.codegen(generator), statements.map{|s| s.codegen(generator, true)}
        if defined? elseif and !elseif.empty?
          code += elseif.codegen(generator)
        end
        code
      end
    end

    class Else < Node
      def codegen(generator, terminate=false)
        generator.else statements.map{|s| s.codegen(generator, true)}
      end
    end

    class String < Node
      def codegen(generator, terminate=false)
        generator.string value
      end
    end

    class Arglist < Node
      def codegen(generator, terminate=false)
        named_args = Hash.new
        args.each do |id,val|
          # TODO: This shouldn't be empty, so there is a problem with the grammar
          next if id.empty? or val.empty?
          named_args[id.value] = val.codegen(generator)
        end
        # For argument lists, the generator requires a name/value hash of each of the
        # arguments.
        generator.arglist named_args
      end
    end

    class Number < Node
      def codegen(generator, terminate=false)
        generator.number value
      end
    end

    class Comment < Node
      # Generate nothing for comments :)
      def codegen(generator, terminate=false)
        ""
      end
    end
  end
end
