with source as (
    select * from {{source( 'lines', 'api_data_table')}}
),

lines as (
    select 
        {{ dbt_utils.generate_surrogate_key(['ResponseTimestamp', 'DatedVehicleJourneyRef', 'Call_stopPointRef', 'Call_AimedDepartureTime']) }} AS surrogate_key,
        ProducerRef                 as producer_ref,
        ResponseTimestamp           as response_timestamp,
        Journey_RecordedAtTime      as journey_recorded_at_time,
        LineRef                     as line_ref,
        DatedVehicleJourneyRef      as dated_vehicle_journey_ref,
        DirectionRef                as direction_ref,
        VehicleMode                 as vehicle_mode,
        PublishedLineName           as published_line_name,
        DestinationRef              as destination_ref,
        DestinationName             as destination_name,
        OperatorRef                 as operator_ref,
        JourneyNote                 as journey_note,
        VehicleJourneyName          as vehicle_journey_name,
        Call_stopPointRef           as call_stop_point_ref,
        Call_DeparturePlatformName  as call_departure_platform_name,
        Call_ArrivalPlatformName    as call_arrival_platform_name,
        Call_DepartureStatus        as call_departure_status,
        Call_ArrivalStatus          as call_arrival_status,
        Call_DestinationDisplay     as call_destination_display,
        Call_ArrivalProximityText   as call_arrival_proximity_text,
        VehicleFeatureRef           as vehicle_feature_ref,
        Call_ExpectedDepartureTime  as call_expected_departure_time,
        Call_ExpectedArrivalTime    as call_expected_arrival_time,
        Call_AimedDepartureTime     as call_aimed_departure_time,
        Call_AimedArrivalTime       as call_aimed_arrival_time
    from source
)

select * from lines

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where response_timestamp > (select max(response_timestamp) from {{ this }}) 
{% endif %}