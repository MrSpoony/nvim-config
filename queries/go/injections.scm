(
  (raw_string_literal) @sql
  (#contains? @sql "WITH" "-- sql" "--sql" "ADD" "ADD CONSTRAINT" "ALL" "ALTER" "AND" "ASC" "COLUMN" "CONSTRAINT" "CREATE" "DATABASE" "DELETE" "DESC" "DISTINCT" "DROP" "EXISTS" "FOREIGN KEY" "FROM" "JOIN" "GROUP BY" "HAVING" "IN" "INDEX" "INSERT INTO" "LIKE" "LIMIT" "NOT" "NOT NULL" "OR" "ORDER BY" "PRIMARY KEY" "SELECT" "SET" "TABLE" "TRUNCATE TABLE" "UNION" "UNIQUE" "UPDATE" "VALUES" "WHERE")
  (#offset! @sql 0 1 0 -1)
)
(
  (interpreted_string_literal) @sql
  (#contains? @sql "-- sql" "--sql" "ADD" "ADD CONSTRAINT" "ALL" "ALTER" "AND" "ASC" "COLUMN" "CONSTRAINT" "CREATE" "DATABASE" "DELETE" "DESC" "DISTINCT" "DROP" "EXISTS" "FOREIGN KEY" "FROM" "JOIN" "GROUP BY" "HAVING" "IN" "INDEX" "INSERT INTO" "LIKE" "LIMIT" "NOT" "NOT NULL" "OR" "ORDER BY" "PRIMARY KEY" "SELECT" "SET" "TABLE" "TRUNCATE TABLE" "UNION" "UNIQUE" "UPDATE" "VALUES" "WHERE")
  (#offset! @sql 0 1 0 -1)
)
(
  (const_spec
    name: (identifier) @_id
    value: (expression_list (raw_string_literal) @sql)
  )
  (#contains? @_id "Query")
  (#offset! @sql 0 1 0 -1)
)
((comment) @injection.content
  (#set! injection.language "comment"))

(call_expression
  (selector_expression) @_function
  (#any-of? @_function "regexp.Match" "regexp.MatchReader" "regexp.MatchString" "regexp.Compile" "regexp.CompilePOSIX" "regexp.MustCompile" "regexp.MustCompilePOSIX")
  (argument_list
    .
    [
      (raw_string_literal)
      (interpreted_string_literal)
    ] @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.language "regex")))

((comment) @injection.content
  (#match? @injection.content "/\\*!([a-zA-Z]+:)?re2c")
  (#set! injection.language "re2c"))

((call_expression
  function:
    (selector_expression
      field: (field_identifier) @_method)
  arguments:
    (argument_list
      .
      (interpreted_string_literal) @injection.content))
  (#any-of? @_method "Printf" "Sprintf" "Fatalf" "Scanf" "Errorf" "Skipf" "Logf")
  (#set! injection.language "printf"))

((call_expression
  function:
    (selector_expression
      field: (field_identifier) @_method)
  arguments:
    (argument_list
      (_)
      .
      (interpreted_string_literal) @injection.content))
  (#any-of? @_method "Fprintf" "Fscanf" "Appendf" "Sscanf")
  (#set! injection.language "printf"))
