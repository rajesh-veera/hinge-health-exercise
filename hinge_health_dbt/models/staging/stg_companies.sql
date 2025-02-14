SELECT
    company_id,
    company_name
FROM {{ source('raw', 'companies') }}
WHERE company_id IS NOT NULL
