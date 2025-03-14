{{ config(
    materialized='incremental',
    unique_key='company_id',
    incremental_strategy='delete+insert',
    merge_update_columns=['company_name'],
    query_comment='This model is responsible for creating a dimension table of companies.'
) }}

select
    company_id
    , company_name
    , now() as loaded_at
from {{ ref('stg_companies') }}
where company_id is not null
{% if is_incremental() %}
and company_id not in (select company_id from {{ this }})
{% endif %}
