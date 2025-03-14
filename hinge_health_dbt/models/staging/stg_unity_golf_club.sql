select
    id as player_id,
    trim(first_name) as first_name,
    trim(last_name) as last_name,
    to_date(cast(dob as text), 'YYYY-MM-DD') as date_of_birth,
    company_id::int as company_id,
    to_Date(cast(last_active as text), 'YYYY-MM-DD') as last_active,
    score::int as score,
    member_since::int as member_since,
    trim(state) as state,
    'Unity Golf Club' as source
from {{ source('raw', 'unity_golf_club') }}
