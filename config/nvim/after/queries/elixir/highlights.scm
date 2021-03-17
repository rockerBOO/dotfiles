(identifier) @variable
(def (identifier) @function)

; (function_name: (variable) @function)

(variable) @variable

; keywords

; [
;  "defmodule"
;  "def"
;  "defp"
;  "end"
;  "try"
; ] @keyword

[
"defmodule"
; "defstruct"
"do"
"def" 
"end"
; "use"
; "import"
] @keyword

(computed_function_name (variable) @function)

(expr_op rhs: (variable) @type)

(defmodule (do_block (variable) @function)) 

; ((module_attribute) @attribute
; (#match? @attribute "^@[a-z]+\s"))

; [
;  "case"
; ;  "else"
; ;  "elsif"
; ;  "if"
; ;  "unless"
; ;  "when"
;  ] @conditional

; (keyword_list ":" @punctuation.delimiter)
; (list "," @punctuation.delimiter)

(case) @conditional

(qualified_function_name 
	module_name: (alias) @type
	function_name: (variable) @function
	)

; (function_call 
;   function_name: (variable) @function)

; (arguments: struct (variable) @parameter)

; (map_entry (atom) @variable)
; (map_entry (atom) ":") @punctuation
; (map "%" @punctuation)
(struct "%" @punctuation)

(list (atom) @property)
(map_entry (atom) @property)
(tuple (atom) @property)
; (arguments: (keyword_list (atom) @property))

(string) @string
(number) @number 
(atom) @property

(function_call (variable) @function) 

; ["in","with"] @keyword

[
  "|"
  "^"
	"\\\\"
	"::"
] @operator

[
 "="
 "=="
 "=>"
 "->"
 "|>"
 "+"
 "-"
 "*"
 "/"
 ] @operator

[
 ","
 "."
 ] @punctuation.delimiter

[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
 ; "%{"
 ] @punctuation.bracket

; ["%{"] @punctuation.bracket

(module_attribute (string) @comment)
