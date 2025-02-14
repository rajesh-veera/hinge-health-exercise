SELECT
    id,
    split_part(name, ' ', 1) as first_name,
    split_part(name, ' ', 2) as last_name,
    TO_DATE(cast(date_of_birth as TEXT), 'YYYY-MM-DD') as dob,
    company_id::int as company_id,
    TO_DATE(cast(last_active as TEXT), 'YYYY-MM-DD') as last_active,
    score::int as score,
    joined_league::int as member_since,
    {{ state_to_abbreviation('us_state')}} as state,
    'us_softball_league' as source
FROM {{ source('raw', 'us_softball_league') }}
