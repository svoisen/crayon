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

module Crayon

  EMPTY_COMMENT = "# \n"
  BLOCK_COMMENT = "#\n# hello\n# goodbye\n#"
  COMMENT = "# Hello world!"
  VAR_ASSIGN = "set x to 10"
  EQUATION_ASSIGN = "set x to 1 + 2 + 3 + 4"
  ARRAY_ASSIGN = "set a to [1, 2, 3, 4, 5, 6, 7]"
  FUNC_RETURN_ASSIGN = "set result to random with min as 0, max as 100"
  SIMPLE_FUNC_CALL = "print y"
  SINGLE_LINE_FUNC_CALL = "draw \"circle\" with radius as 10, color as \"black\""
  MULTILINE_FUNC_CALL = "draw \"circle\" with\n\tradius as 10\n\tcolor as \"black\"\nend"
  FUNC_CALL_NO_DEFAULT = "draw_circle with center as [50, 50]"
  FUNC_CALL_NO_PARAMS = "clear!"
  SIMPLE_LOOP = "repeat 10 times\nend"
  SIMPLE_COUNTER_LOOP = "repeat 10 times with i\nend"
  LOOP = "repeat i from 0 to 10\nend"
  WHILE_LOOP = "repeat while x < 10\nend"
  IF = "if x < 10\nend"
  INLINE_IF = "print \"hello\" if true"
  IF_ELSE = "if x ≥ y\nprint y\nelse\nprint x\nend"
  IF_ELSE_IF = "if x ≥ y\nprint y\nelse if x < y\nprint x\nend"
  IF_ELSE_IF_ELSE_IF = "if x > y\nprint x\nelse if x < y\nprint y\nelse if x = y\nprint 0\nend"
  UNLESS = "unless x < 10\nend"
  INLINE_UNLESS = "print \"hello\" unless true"
  OBJECT_PROPERTY = "print length of list"
  LIST_ITEM_NUMBER = "print item 5 of list"
  LIST_ITEM_VAR = "print item i of list"
  START_EVENT = "do my_function on frame"
  STOP_EVENT = "stop doing my_function on frame"
  FUNCTION_WITH_PARAMS = "function hello_world uses saying\nprint saying\nend"
  FUNCTION_WITHOUT_PARAMS = "function hello_world\nprint \"hello world\"\nend"
  EVENT_START = "do my_function on frame"
  EVENT_STOP = "stop doing my_function on frame"

end
