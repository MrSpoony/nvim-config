(
  (raw_string_literal) @pgsql
  (#contains? @pgsql "WITH" "-- sql" "--sql" "ADD" "ADD CONSTRAINT" "ALL" "ALTER" "AND" "ASC" "COLUMN" "CONSTRAINT" "CREATE" "DATABASE" "DELETE" "DESC" "DISTINCT" "DROP" "EXISTS" "FOREIGN KEY" "FROM" "JOIN" "GROUP BY" "HAVING" "IN" "INDEX" "INSERT INTO" "LIKE" "LIMIT" "NOT" "NOT NULL" "OR" "ORDER BY" "PRIMARY KEY" "SELECT" "SET" "TABLE" "TRUNCATE TABLE" "UNION" "UNIQUE" "UPDATE" "VALUES" "WHERE")
  (#offset! @pgsql 0 1 0 -1)
)
(
  (interpreted_string_literal) @pgsql
  (#contains? @pgsql "-- sql" "--sql" "ADD" "ADD CONSTRAINT" "ALL" "ALTER" "AND" "ASC" "COLUMN" "CONSTRAINT" "CREATE" "DATABASE" "DELETE" "DESC" "DISTINCT" "DROP" "EXISTS" "FOREIGN KEY" "FROM" "JOIN" "GROUP BY" "HAVING" "IN" "INDEX" "INSERT INTO" "LIKE" "LIMIT" "NOT" "NOT NULL" "OR" "ORDER BY" "PRIMARY KEY" "SELECT" "SET" "TABLE" "TRUNCATE TABLE" "UNION" "UNIQUE" "UPDATE" "VALUES" "WHERE")
  (#offset! @pgsql 0 1 0 -1)
)
(
  (const_spec
    name: (identifier) @_id
    value: (expression_list (raw_string_literal) @pgsql)
  )
  (#contains? @_id "Query")
  (#offset! @pgsql 0 1 0 -1)
)
