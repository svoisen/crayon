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

    it "should allow equation results as repeat loop variable" do
      parse("repeat width of canvas / 10 times\nend").should_not be_nil
    end
  end

end

