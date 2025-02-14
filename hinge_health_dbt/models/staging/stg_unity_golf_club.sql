SELECT
    id,
    TRIM(first_name) as first_name,
    TRIM(last_name) as last_name,
    TO_DATE(cast(dob as TEXT), 'YYYY-MM-DD') as dob,
    company_id::int as company_id,
    TO_DATE(cast(last_active as TEXT), 'YYYY-MM-DD') as last_active,
    score::int as score,
    member_since::int as member_since,
    UPPER(SUBSTRING(state, 1, 2)) as state
FROM {{ source('raw', 'unity_golf_club') }}
