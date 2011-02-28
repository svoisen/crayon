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

    it "should parse equation assignments" do
      parse(EQUATION_ASSIGN).should_not be_nil
    end

    it "should parse function result assignments" do
      parse(FUNC_RETURN_ASSIGN).should_not be_nil
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

    it "should parse function calls without default parameters" do
      parse(FUNC_CALL_NO_DEFAULT).should_not be_nil
    end

    it "should parse function calls without any parameters" do
      parse(FUNC_CALL_NO_PARAMS).should_not be_nil
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

    it "should parse inline if statements" do
      parse(INLINE_IF).should_not be_nil
    end

    it "should parse inline unless statements" do
      parse(INLINE_UNLESS).should_not be_nil
    end

    it "should parse if ... else statements" do
      parse(IF_ELSE).should_not be_nil
    end

    it "should parse if ... else if statements" do
      parse(IF_ELSE_IF).should_not be_nil
    end

    it "should parse if ... else if ... else if ... statements" do
      parse(IF_ELSE_IF_ELSE_IF).should_not be_nil
    end

    it "should parse unless statements" do
      parse(UNLESS).should_not be_nil
    end

    it "should parse function defintions that have parameters" do
      parse(FUNCTION_WITH_PARAMS).should_not be_nil
    end

    it "should parse function definitions that have no parameters" do
      parse(FUNCTION_WITHOUT_PARAMS).should_not be_nil
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

    it "should parse start handling events" do
      parse(EVENT_START).should_not be_nil
    end

    it "should parse stop handling events" do
      parse(EVENT_STOP).should_not be_nil
    end

  end

end
