$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'treetop'
require 'parser/crayon'
require 'snippets'

module Crayon

  describe Parser::CrayonParser do

    before(:all) do
      @parser = Parser::CrayonParser.new
    end

    it "should allow comments" do
      @parser.parse(COMMENT).should_not be_nil
    end

    it "should parse simple function calls" do
      @parser.parse("print y").should_not be_nil
    end

    it "should parse simple loops" do
      @parser.parse("repeat 10 times\nend").should_not be_nil
    end

    it "should parse simple loops with counters" do
      @parser.parse("repeat 10 times with i\nend").should_not be_nil
    end

    it "should parse loops with start/end" do
      @parser.parse("repeat i from 0 to 10\nend").should_not be_nil
    end

    it "should parse while loops" do
      @parser.parse("repeat while i < 10\nend").should_not be_nil
    end

    it "should parse if statements" do
      @parser.parse("if x < 10\nend").should_not be_nil
    end

    it "should parse if ... else statements" do
      @parser.parse("if x ≥ y\nprint y\nelse\nprint x\nend").should_not be_nil
    end

    it "should parse function defintions" do
      @parser.parse("function hello_world uses x, y\nend")
    end

  end

end
