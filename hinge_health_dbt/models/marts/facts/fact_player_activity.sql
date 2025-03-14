{{ config(
    materialized='incremental',
    unique_key=['player_sk', 'last_active'],
    incremental_strategy='delete+insert',
    query_comment='This model is responsible for creating a fact table of Players score, active.'
) }}

with cte as
(
    select
        dim_players.player_sk
        , dim_companies.company_id
        , last_active
        , member_since
        , state
        , score
        , extract(year from age(last_active, int_members.date_of_birth)) as age_when_last_active
        , extract(year from age(current_date, last_active)) as years_since_last_active
        , extract(year from age(current_date, int_members.date_of_birth)) as current_age_years
        , source
        , now() as loaded_at
    from {{ ref('int_members') }} as int_members
    join {{ ref('dim_players') }} as dim_players on dim_players.player_full_name = int_members.player_full_name and dim_players.date_of_birth = int_members.date_of_birth
    left join {{ ref('dim_companies') }} as dim_companies on dim_companies.company_id = int_members.company_id
    where is_suspect_record = false
    {% if is_incremental() %}
    and not exists (select 1 from {{ this }} src where src.player_sk = dim_players.player_sk and src.last_active = int_members.last_active)
    {% endif %}
)
select * from cte
