select
    id::int as player_id,
    trim(name) as player_name,
    to_date(cast(date_of_birth as text), 'YYYY-MM-DD') as date_of_birth,
    company_id::int as company_id,
    to_date(cast(last_active as text), 'YYYY-MM-DD') as last_active,
    score::int as score,
    joined_league::int as member_since,
    trim(us_state)::text as state,
    'US Softball League' as source
from {{ source('raw', 'us_softball_league') }}
