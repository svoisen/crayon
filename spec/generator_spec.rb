$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'treetop'
require 'parser/crayon'
require 'generator/as3_generator'
require 'snippets'

module Crayon

  describe Generator::AS3Generator do
    def generate(code)
      @parser.parse(code).statements.first.codegen(@generator)
    end

    before(:all) do
      @parser = Parser::CrayonParser.new
      @generator = Generator::AS3Generator.new("generator_spec")
    end

    it "should generate basic function calls" do
      generate(SIMPLE_FUNC_CALL).should == "print({__default:y});"
    end

    it "should generate variable assignments" do
      generate(VAR_ASSIGN).should == "var x:* = 10;"
    end

    it "should generate list assignements" do
      generate(ARRAY_ASSIGN).should == "var a:* = [1,2,3,4,5,6,7];"
    end

    it "should generate basic if statements" do
      generate(IF).should == "if(x < 10)\n{\n\n}"
    end

    it "should generate while loops" do
      generate(WHILE_LOOP).should == "while(x < 10)\n{\n\n}"
    end

    it "should generate code to access list items by number" do
      generate(LIST_ITEM_NUMBER).should == "print({__default:list[5]});"
    end

    it "should generate code to access list items by variable" do
      generate(LIST_ITEM_VAR).should == "print({__default:list[i]});"
    end

  end
end
