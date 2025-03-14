with unity_golf_club_members as
(
    select
        player_id
        , first_name || ' ' || last_name as player_full_name
        , date_of_birth
        , company_id
        , last_active
        , member_since
        , score
        , state
        , source
    from {{ ref('stg_unity_golf_club') }}
)
, us_softball_league_members as
(
    select
        player_id
        , player_name as player_full_name
        , date_of_birth
        , company_id
        , last_active
        , member_since
        , score
        , {{ state_to_abbreviation('state')}} as state
        , source
    from {{ ref('stg_us_softball_league') }}
)
, final as
(
    select * from unity_golf_club_members
    union all
    select * from us_softball_league_members
)
select
    *
    , case
            when date_of_birth > last_active then TRUE
            when member_since < extract(year from date_of_birth) then TRUE
            else FALSE
        end as is_suspect_record
from final
