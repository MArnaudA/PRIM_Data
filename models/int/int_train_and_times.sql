with lines as (
    select * from {{ ref('stg_lines')}}
),

stop_points as (
    select * from {{ ref('stg_line_references')}}
)

select
    surrogate_key,
    response_timestamp,
    published_line_name          as line_name,
    vehicle_journey_name         as train_name,
    stop_points.stop_name        as current_stop_name,
    call_aimed_arrival_time      as aimed_arrival_time,
    call_aimed_departure_time    as aimed_departure_time,
    call_expected_arrival_time   as expected_arrival_time,
    call_expected_departure_time as expected_departure_time 
from
    lines
    join stop_points on lines.call_stop_point_ref = stop_points.stop_point_ref


    