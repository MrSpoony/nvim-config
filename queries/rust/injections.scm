(macro_invocation
  macro: (identifier) @macro (#any-of? @macro "view")
  (token_tree) @injection.content (#offset! @injection.content 0 2 0 -2)
  (#set! injection.language "html"))

(macro_invocation
  macro: (identifier) @macro (#any-of? @macro "query" "query_as")
  (token_tree
    (string_literal) @injection.content
    (#offset! @injection.content 0 1 0 -1))
  (#set! injection.language "sql"))

(macro_invocation
  macro: (identifier) @macro (#any-of? @macro "query" "query_as")
  (token_tree
    (raw_string_literal) @injection.content
    (#offset! @injection.content 0 3 0 -2))
  (#set! injection.language "sql"))
