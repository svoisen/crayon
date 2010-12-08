$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'treetop'
require 'parser/crayon'

module Crayon

  describe Parser::CrayonParser do
    it "should allow comments" do
      parser = Parser::CrayonParser.new
      node = parser.parse("# Hi")
      puts parser.failure_reason
      node.should_not be_nil
    end

    it "should parse simple loops" do
      parser = Parser::CrayonParser.new
      node = parser.parse("repeat 10 times with i\r\nend")
      puts parser.failure_reason
      node.should_not be_nil
    end
  end

end
