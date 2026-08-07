
[
  "alias"
  "begin"
  "break"
  "case"
  "class"
  "def"
  "do"
  "else"
  "elsif"
  "end"
  "ensure"
  "if"
  "in"
  "module"
  "next"
  "rescue"
  "return"
  "then"
  "unless"
  "until"
  "when"
  "while"
  "yield"
] @keyword

"require" @function.method.builtin

[
  (self)
] @variable.builtin

(comment) @comment
(operator) @operator

(string) @string
(operator) @punctuation.operator

; Literals/Primitives

(symbol) @string.special.symbol
(regex) @string.special.regex

(string) @string

[
 (integer)
 (float)
] @number

[
 (nil)
 (true)
 (false)
] @constant.builtin

[ 
	"->"
	"&&" 
] @operator

(instance_var) @variable.builtin

(interpolation
  "#{" @punctuation.special
  "}" @punctuation.special)

; Punctuation

[
 ";"
 "."
 ","
] @punctuation.delimiter

[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
 "|"
] @punctuation.bracket


[ "?" ":" ] @punctuation.delimiter

; Identifiers

(identifier) @variable

(constant) @constant

; Operators

; [
; "="
; "=>"
; "->"
; ] @operator

[
  ","
  ";"
  "."
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket
