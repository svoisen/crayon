require "rubygems"
require "treetop"

# Use compiled grammar if it exists, otherwise load grammar definition
if File.file?(File.dirname(__FILE__) + "/language/grammar.rb")
  require "language/grammar"
else
  Treetop.load File.dirname(__FILE__) + "/language/grammar.tt"
end

module Crayon
  class ParserError < RuntimeError; end

  def self.compile(code)
    parser = CrayonParser.new

    if parser.parse(code)
      puts 'success'
    else
      puts 'failure'
    end
  end
end

File.open(ARGV[0], "r") do |file|
  code = ''
  file.each_line{|line| code += line}

  Crayon.compile(code)
end
