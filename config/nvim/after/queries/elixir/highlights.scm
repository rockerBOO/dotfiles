
;; anonymous

"(" @punctuation.bracket
")" @punctuation.bracket
"=" @operator
"==" @operator
"=>" @operator
"->" @operator
"!" @operator
"+" @operator
"-" @operator
"<>" @operator
"<<" @operator
">>" @operator
"::" @operator
"," @punctuation.delimiter
"[" @punctuation.bracket
"]" @punctuation.bracket

"case" @keyword
"cond" @keyword
"fn" @keyword
"do" @keyword
"end" @keyword
"def" @keyword
"defp" @keyword

"for" @keyword
"if" @keyword
"unless" @keyword
"when" @keyword

;; Function calls

; (qualified_function_name
;  "." @operator
;  function_name: (variable) @function.call)

(computed_function_name
 (variable) @function.call)

;; Definitions
(defmodule
  "defmodule" @keyword
  modulename: (_) @type
  (do_block))

(module_attribute
 "@" @property
 (identifier) @property
 (_))

(def
 ["def" "defp"]
 [(atom)
  (identifier) @function]
 arguments: (variable)?
 (guard_clause)?
 (do_block))

(do_block
 [("do" @keyword
   (_)
   "end" @keyword)
  (", " @punctuation.delimiter
   "do:" @keyword
   (_))])

(alias) @type

;; Literals
(number) @number

((variable) @comment
 (.match? @comment "^_"))
(variable) @variable

(boolean) @constant.builtin
(comment) @comment

;; string

(interpolation
 "#{" @punctuation.special
 (_)?
 "}" @punctuation.special)

(module_attribute
 "@" @property.definition
 ((identifier) @property
  (.match? @property "doc$"))
 (string) @comment)

(string) @string

(charlist) @string

(char) @string

(bin_type) @type.builtin

;; map

(map
 "%" @punctuation.special
 "{" @punctuation.special
 "}" @punctuation.special)

(struct
 "%" @punctuation.special
 "{" @punctuation.special
 "}" @punctuation.special)

;; sigil

(sigil) @string

; (identifier) @variable
(def (identifier) @function)

; ; (function_name: (variable) @function)

; (variable) @variable

; ; keywords

; ; [
; ;  "defmodule"
; ;  "def"
; ;  "defp"
; ;  "end"
; ;  "try"
; ; ] @keyword

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

; ; ((module_attribute) @attribute
; ; (#match? @attribute "^@[a-z]+\s"))

; ; [
; ;  "case"
; ; ;  "else"
; ; ;  "elsif"
; ; ;  "if"
; ; ;  "unless"
; ; ;  "when"
; ;  ] @conditional

; ; (keyword_list ":" @punctuation.delimiter)
; ; (list "," @punctuation.delimiter)

; (case) @conditional

(qualified_function_name 
	module_name: (alias) @type
	function_name: (variable) @function
	)

; ; (function_call 
; ;   function_name: (variable) @function)

; ; (arguments: struct (variable) @parameter)

; ; (map_entry (atom) @variable)
; ; (map_entry (atom) ":") @punctuation
; ; (map "%" @punctuation)
(struct "%" @punctuation)

(list (atom) @property)
(map_entry (atom) @property)
(tuple (atom) @property)
; ; (arguments: (keyword_list (atom) @property))

(string) @string
(number) @number 
(atom) @property
; (comment) @comment

(function_call (variable) @function) 

; ; ["in","with"] @keyword

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

; ; ["%{"] @punctuation.bracket

(module_attribute (string) @comment)
