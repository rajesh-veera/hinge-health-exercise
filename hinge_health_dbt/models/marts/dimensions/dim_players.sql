{{ config(
    materialized='incremental',
    unique_key='player_sk',
    incremental_strategy='delete+insert',
    query_comment='This model is responsible for creating a dimension table of Players.'
) }}

select
    {{ dbt_utils.generate_surrogate_key(['player_full_name', 'date_of_birth']) }} as player_sk
    , player_full_name
    , date_of_birth
    , now() as loaded_at
from {{ ref('int_members') }}
{% if is_incremental() %}
where not exists (select 1 from {{ this }} src where src.player_full_name = int_members.player_full_name and src.date_of_birth = int_members.date_of_birth)
{% endif %}
group by 1, 2, 3, 4
