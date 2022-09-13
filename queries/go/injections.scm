(
  (raw_string_literal) @sql
  (#contains? @sql "-- sql" "--sql")
  (#offset! @sql 0 1 0 -1)
)
(
  (interpreted_string_literal) @sql
  (#contains? @sql "-- sql" "--sql")
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
