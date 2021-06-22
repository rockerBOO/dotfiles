; highlights for https://gitlab.com/greggreg/tree-sitter-gleam

"import" @keyword
"fn" @keyword
"pub" @keyword

(function_statement
  name: (identifier) @function)

"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

"->" @operator
"|>" @operator

"," @punctuation.delimiter
"." @punctuation.delimiter

(module_path "/" @punctuation.delimiter)

(named_parameter ":" @punctuation.delimiter)

(module_identifier) @variable
(discard_identifier) @variable
; (identifier "fn" @keyword)

(generic_type) @type
(type_identifier) @type
(identifier) @property
(string_literal) @string
