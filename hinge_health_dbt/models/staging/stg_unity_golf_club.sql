SELECT
    id,
    TRIM(first_name) as first_name,
    TRIM(last_name) as last_name,
    TO_DATE(CAST(dob as TEXT), 'YYYY-MM-DD') as dob,
    company_id::int as company_id,
    TO_DATE(CAST(last_active as TEXT), 'YYYY-MM-DD') as last_active,
    score::INT as score,
    member_since::int as member_since,
    UPPER(SUBSTRING(state, 1, 2)) as state,
    'unity_golf_club' as source
FROM {{ source('raw', 'unity_golf_club') }}
