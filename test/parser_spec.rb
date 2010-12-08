$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'treetop'
require 'parser/crayon'

module Crayon

  describe Parser::CrayonParser do

    before(:all) do
      @parser = Parser::CrayonParser.new
    end

    it "should allow comments" do
      @parser.parse("# Hello world!").should_not be_nil
    end

    it "should parse simple loops" do
      @parser.parse("repeat 10 times\nend").should_not be_nil
    end

    it "should parse simple loops with counters" do
    end

    it "should parse 'for-style' loops" do
    end

    it "should parse while loops" do
    end

  end

end
