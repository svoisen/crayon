# Copyright (c) 2010-2011 Sean Voisen.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


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
  def codegen(context, terminate=false, parenthesize=false)
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

    class Call < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.call function.value, (defined? arglist and !arglist.empty?) ? arglist.codegen(generator) : "", terminate, parenthesize
      end
    end

    class InlineCall < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.call function.value, (defined? inline_arglist and !inline_arglist.empty?) ? inline_arglist.codegen(generator) : "", terminate, parenthesize
      end
    end

    class Assignment < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.assign vars.map{|v| v.codegen(generator)}, expression.codegen(generator), terminate
      end
    end

    class Comparison < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.compare compareop.value, value.codegen(generator), expression.codegen(generator), parenthesize
      end
    end

    class Equation < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.calculate mathop.value, value.codegen(generator), expression.codegen(generator), parenthesize
      end
    end

    class CountLoop < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.start_scope
        code = generator.loop((!defined? counter or !defined? counter.varprop) ? "__i" : counter.varprop.codegen(generator),
                       (!defined? i_start or i_start.empty?) ? 0 : i_start.codegen(generator),
                       i_end.codegen(generator),
                       (defined? i_start and !i_start.empty?),
                       statements.map{|s| s.codegen(generator, true)})
        generator.end_scope
        code
      end
    end

    class Property < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.property property.value, object.codegen(generator), parenthesize
      end
    end

    class Method < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.method object.value, call.codegen(generator), parenthesize
      end
    end

    class WhileLoop < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.start_scope
        code = generator.while condition.codegen(generator), statements.map{|s| s.codegen(generator, true)}
        generator.end_scope
        code
      end
    end

    class Variable < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.var identifier.value, parenthesize
      end
    end

    class List < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.array items.map{|i| i.codegen(generator)}, terminate, parenthesize
      end
    end

    class ListItem < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.array_item item.codegen(generator), list.codegen(generator), parenthesize
      end
    end

    class Function < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.start_scope
        args.each{|a| generator.add_to_scope(a.value)}
        code = generator.function name.codegen(generator), args.map{|a| a.value}, statements.map{|s| s.codegen(generator, true)}
        generator.end_scope
        code
      end
    end

    class If < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.start_scope
        code = generator.if condition.codegen(generator), statements.map{|s| s.codegen(generator, true)}
        generator.end_scope
        if defined? els and !els.empty?
          code += els.codegen(generator)
        end
        if defined? elseif and !elseif.empty?
          code += elseif.codegen(generator)
        end
        code
      end
    end

    class InlineIf < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.if condition.codegen(generator), inline_statement.codegen(generator, true)
      end
    end

    class ElseIf < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.start_scope
        code = generator.elseif condition.codegen(generator), statements.map{|s| s.codegen(generator, true)}
        generator.end_scope
        if defined? elseif and !elseif.empty?
          code += elseif.codegen(generator)
        end
        code
      end
    end

    class Else < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.start_scope
        code = generator.else statements.map{|s| s.codegen(generator, true)}
        generator.end_scope
        code
      end
    end

    class Unless < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.start_scope
        code = generator.unless condition.codegen(generator), statements.map{|s| s.codegen(generator, true)}
        generator.end_scope
        code
      end
    end

    class InlineUnless < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.unless condition.codegen(generator), inline_statement.codegen(generator, true)
      end
    end

    class EventStart < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.add_listener function.codegen(generator), event_name.value
      end
    end

    class EventStop < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.remove_listener function.codegen(generator), event_name.value
      end
    end

    class String < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.string value, parenthesize
      end
    end

    class Boolean < Node
      def codegen(generator, terminate=false, parenthesize=false)
        generator.boolean value, parenthesize
      end
    end

    class Arglist < Node
      def codegen(generator, terminate=false, parenthesize=false)
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
      def codegen(generator, terminate=false, parenthesize=false)
        generator.number value, parenthesize
      end
    end

    class Comment < Node
      # Generate nothing for comments :)
      def codegen(generator, terminate=false, parenthesize=false)
        ""
      end
    end
  end
end
