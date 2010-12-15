$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'treetop'
require 'parser/crayon'
require 'generator/as3_generator'

module Crayon

  describe Generator::AS3Generator do

    before(:all) do
      @parser = Parser::CrayonParser.new
      @generator = Generator::AS3Generator.new("generator_spec")
    end

    it "should generate basic function calls" do
      node = @parser.parse("print x")
      node.expressions.first.codegen(@generator).should == "print({__default:x})"
    end

  end
end
