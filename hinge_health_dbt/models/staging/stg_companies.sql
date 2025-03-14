select
    company_id::int as company_id,
    trim(company_name)::text as company_name
from {{ source('raw', 'companies') }}
