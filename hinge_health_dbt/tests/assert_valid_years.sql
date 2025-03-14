with combined_members as (
    select * from {{ ref('int_members') }}
)

select *
from combined_members
where date_of_birth > current_date
    or date_of_birth > last_active
