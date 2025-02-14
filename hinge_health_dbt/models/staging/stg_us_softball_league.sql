SELECT
    id,
    TRIM(name) as name,
    TO_DATE(cast(date_of_birth as TEXT), 'YYYY-MM-DD') as date_of_birth,
    company_id::int as company_id,
    TO_DATE(cast(last_active as TEXT), 'YYYY-MM-DD') as last_active,
    score::int as score,
    joined_league::int as joined_league,
    {{ state_to_abbreviation('us_state')}} as state_to
FROM {{ source('raw', 'us_softball_league') }}
