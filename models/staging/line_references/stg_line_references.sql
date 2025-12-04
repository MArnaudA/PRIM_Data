with line_references as (
    select * from {{ source('line_references', 'arrets') }}
),

stop_names as (
    select 
        line,
        name_line,
        ns2_stoppointref    as stop_point_ref,
        ns2_stopname        as stop_name,
        ns2_lines           as lines,
        ns2_location        as location
    
    from line_references
)

select * from stop_names