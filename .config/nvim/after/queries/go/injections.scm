; extends

(call_expression
  function: (selector_expression
    field: (field_identifier) @_method)
  arguments: (argument_list
    .
    [
      (raw_string_literal
        (raw_string_literal_content) @injection.content)
      (interpreted_string_literal
        (interpreted_string_literal_content) @injection.content)
    ])
  (#any-of? @_method 
    "Exec" "ExecContext" "MustExec" "NamedExec"
    "Query" "QueryContext" "Queryx" "QueryxContext" "QueryRow" "QueryRowContext" "QueryRowx" "QueryRowxContext"
    "Get" "GetContext" "Select" "SelectContext"
    "Rebind" "RebindNamed" "In" "Raw")
  (#set! injection.language "sql"))

(call_expression
  function: (selector_expression
    field: (field_identifier) @_method)
  arguments: (argument_list
    (_)
    .
    [
      (raw_string_literal
        (raw_string_literal_content) @injection.content)
      (interpreted_string_literal
        (interpreted_string_literal_content) @injection.content)
    ])
  (#any-of? @_method 
    "Exec" "ExecContext" "MustExec" "NamedExec"
    "Query" "QueryContext" "Queryx" "QueryxContext" "QueryRow" "QueryRowContext" "QueryRowx" "QueryRowxContext"
    "Get" "GetContext" "Select" "SelectContext"
    "Rebind" "RebindNamed" "In" "Raw")
  (#set! injection.language "sql"))

([
  (raw_string_literal
    (raw_string_literal_content) @injection.content)
  (interpreted_string_literal
    (interpreted_string_literal_content) @injection.content)
]
  (#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set)")
  (#set! injection.language "sql"))

([
  (raw_string_literal
    (raw_string_literal_content) @injection.content)
  (interpreted_string_literal
    (interpreted_string_literal_content) @injection.content)
]
  (#contains? @injection.content "-- sql" "--sql" 
    "ADD CONSTRAINT" "ALTER TABLE" "ALTER COLUMN" "CREATE INDEX" "CREATE TABLE"
    "DATABASE" "FOREIGN KEY" "GROUP BY" "HAVING" "INSERT INTO" "INNER JOIN" "LEFT JOIN" "RIGHT JOIN"
    "NOT NULL" "PRIMARY KEY" "UPDATE SET" "TRUNCATE TABLE" 
    "add constraint" "alter table" "alter column" "create index" "create table"
    "database" "foreign key" "group by" "having" "insert into" "inner join" "left join" "right join"
    "not null" "primary key" "update set" "truncate table")
  (#set! injection.language "sql"))

(const_spec
  name: ((identifier) @_const (#lua-match? @_const ".*[J|j]son.*"))
  value: (expression_list
    (raw_string_literal
      (raw_string_literal_content) @injection.content))
  (#set! injection.language "json"))

(var_spec
  name: ((identifier) @_var (#lua-match? @_var ".*[J|j]son.*"))
  value: (expression_list
    (raw_string_literal
      (raw_string_literal_content) @injection.content))
  (#set! injection.language "json"))

(short_var_declaration
  left: (expression_list (identifier) @_var (#lua-match? @_var ".*[J|j]son.*"))
  right: (expression_list
    (raw_string_literal
      (raw_string_literal_content) @injection.content))
  (#set! injection.language "json"))
