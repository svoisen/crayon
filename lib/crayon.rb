require "rubygems"
require "treetop"

require "generator"
require "nodes"

# Use compiled grammar if it exists, otherwise load grammar definition
if File.file?(File.dirname(__FILE__) + "grammar.rb")
  require "grammar"
else
  Treetop.load File.dirname(__FILE__) + "grammar.tt"
end

module Crayon
  class ParserError < RuntimeError; end

  def self.compile(code)
    generator = Crayon::Generator.new
    parser = CrayonParser.new

    if node = parser.parse(code)
      node.compile(generator)
    else
      raise ParserError, parser.failure_reason
    end
  end
end

File.open(ARGV[0], "r") do |file|
  code = ''
  file.each_line{|line| code += line}

  puts Crayon.compile(code)
end
