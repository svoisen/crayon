$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'treetop'
require 'parser/crayon'
require 'generator/as3_generator'
require 'snippets'

module Crayon

  describe Generator::AS3Generator do
    def generate(code)
      @generator.reset
      @parser.parse(code).statements.first.codegen(@generator, true)
    end

    before(:all) do
      @parser = Parser::CrayonParser.new
      @generator = Generator::AS3Generator.new("generator_spec")
    end

    it "should generate basic function calls" do
      generate(SIMPLE_FUNC_CALL).should == "print({__default:__y});"
    end

    it "should generate variable assignments" do
      generate(VAR_ASSIGN)
      @generator.class_vars.first[:initializer].should == "__x = 10;"
      @generator.class_vars.first[:declaration].should == "private var __x:*;"
    end

    it "should generate list assignments" do
      generate(ARRAY_ASSIGN)
      @generator.class_vars.first[:initializer].should == "a = [1,2,3,4,5,6,7];"
      @generator.class_vars.first[:declaration].should == "private var a:*;"
    end

    it "should generate basic if statements" do
      generate(IF).should == "if(__x < 10)\n{\n\n}"
    end

    it "should generate inline if statements" do
      generate(INLINE_IF).should == "if(true)\n{\n  print({__default:\"hello\"});\n}"
    end

    it "should generate if else statements" do
      generate(IF_ELSE).should == "if(__x >= __y)\n{\n  print({__default:__y});\n}\nelse\n{\n  print({__default:__x});\n}"
    end

    it "should generate if ... else if statements" do
      generate(IF_ELSE_IF).should == "if(__x >= __y)\n{\n  print({__default:__y});\n}\nelse if(__x < __y)\n{\n  print({__default:__x});\n}"
    end

    it "should generate if ... else if ... else if statements" do
      generate(IF_ELSE_IF_ELSE_IF).should == "if(__x > __y)\n{\n  print({__default:__x});\n}\nelse if(__x < __y)\n{\n  print({__default:__y});\n}\nelse if(__x == __y)\n{\n  print({__default:0});\n}"
    end

    it "should generate unless statements" do
      generate(UNLESS).should == "if(!(__x < 10))\n{\n\n}"
    end

    it "should generate inline unless statements" do
      generate(INLINE_UNLESS).should == "if(!(true))\n{\n  print({__default:\"hello\"});\n}"
    end

    it "should generate while loops" do
      generate(WHILE_LOOP).should == "while(__x < 10)\n{\n\n}"
    end

    it "should generate simple loops" do
      generate(SIMPLE_LOOP).should == "for(var __i:int = 0; __i < 10; __i++)\n{\n\n}"
    end

    it "should generate code to access list items by number" do
      generate(LIST_ITEM_NUMBER).should == "print({__default:list[5]});"
    end

    it "should generate code to access list items by variable" do
      generate(LIST_ITEM_VAR).should == "print({__default:list[i]});"
    end

    it "should generate function calls without default parameters" do
      generate(FUNC_CALL_NO_DEFAULT).should == "draw_circle({center:[50,50]});"
    end

    it "should generate code to assign function results to variables" do
      generate(FUNC_RETURN_ASSIGN)
      @generator.class_vars.first[:initializer].should == "result = random({max:100,min:0});"
      @generator.class_vars.first[:declaration].should == "private var result:*;"
    end

    it "should generate code for functions without parameters" do
      @parser.parse(FUNCTION_WITHOUT_PARAMS).statements.first.codegen(@generator, true, true).should == "function hello_world():*\n{\n\n  print({__default:\"hello world\"});\n}"
    end

    it "should generate code for functions with parameters" do
      @parser.parse(FUNCTION_WITH_PARAMS).statements.first.codegen(@generator, true, true).should == "function hello_world(params:Object):*\n{\n  var saying:* = params.saying;\n  print({__default:saying});\n}"
    end

    it "should generate code to listen for events" do
      generate(EVENT_START).should == "addEventListener(Event.ENTER_FRAME, my_function);"
    end

    it "should generate code to stop listening for events" do
      generate(EVENT_STOP).should == "removeEventListener(Event.ENTER_FRAME, my_function);"
    end

  end
end