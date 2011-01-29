module Crayon

  EMPTY_COMMENT = "# \n"
  BLOCK_COMMENT = "#\n# hello\n# goodbye\n#"
  COMMENT = "# Hello world!"
  VAR_ASSIGN = "set x to 10"
  ARRAY_ASSIGN = "set a to (1, 2, 3, 4, 5, 6, 7)"
  SIMPLE_FUNC_CALL = "print y"
  SINGLE_LINE_FUNC_CALL = "draw circle with radius as 10, color as black"
  MULTILINE_FUNC_CALL = "draw circle with\n\tradius as 10\n\tcolor as black\nend"
  SIMPLE_LOOP = "repeat 10 times\nend"
  SIMPLE_COUNTER_LOOP = "repeat 10 times with i\nend"
  LOOP = "repeat i from 0 to 10\nend"
  WHILE_LOOP = "repeat while x < 10\nend"
  IF = "if x < 10\nend"
  IF_ELSE = "if x ≥ y\nprint y\nelse\nprintx\nend"
  OBJECT_PROPERTY = "print length of list"
  LIST_ITEM_NUMBER = "print item 5 of list"
  LIST_ITEM_VAR = "print item i of list"

end
