$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'treetop'
require 'parser/crayon'
require 'snippets'

module Crayon

  describe Parser::CrayonParser do
    def parse(code)
      @parser.parse(code)
    end

    before(:all) do
      @parser = Parser::CrayonParser.new
    end

    it "should allow block comments" do
      parse(BLOCK_COMMENT).should_not be_nil
    end

    it "should allow comments" do
      parse(COMMENT).should_not be_nil
    end

    it "should allow empty comments" do
      parse(EMPTY_COMMENT).should_not be_nil
    end

    it "should parse variable assignments" do
      parse(VAR_ASSIGN).should_not be_nil
    end

    it "should parse list assignments" do
      parse(ARRAY_ASSIGN).should_not be_nil
    end

    it "should parse simple function calls" do
      parse(SIMPLE_FUNC_CALL).should_not be_nil
    end

    it "should parse single line function calls" do
      parse(SINGLE_LINE_FUNC_CALL).should_not be_nil
    end

    it "should parse multi-line function calls" do
      parse(MULTILINE_FUNC_CALL).should_not be_nil
    end

    it "should parse simple loops" do
      parse(SIMPLE_LOOP).should_not be_nil
    end

    it "should parse simple loops with counters" do
      parse(SIMPLE_COUNTER_LOOP).should_not be_nil
    end

    it "should parse loops with start/end" do
      parse(LOOP).should_not be_nil
    end

    it "should parse while loops" do
      parse(WHILE_LOOP).should_not be_nil
    end

    it "should parse if statements" do
      parse(IF).should_not be_nil
    end

    it "should parse if ... else statements" do
      parse("IF_ELSE").should_not be_nil
    end

    it "should parse function defintions" do
      parse("function hello_world uses x, y\nend").should_not be_nil
    end

    it "should parse object properties" do
      parse(OBJECT_PROPERTY).should_not be_nil
    end

    it "should parse list item access by number" do
      parse(LIST_ITEM_NUMBER).should_not be_nil
    end

    it "should parse list item access by variable" do
      parse(LIST_ITEM_VAR).should_not be_nil
    end

  end

end
