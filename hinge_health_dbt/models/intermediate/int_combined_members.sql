WITH softball_members AS 
(
    SELECT * from {{ ref('stg_us_softball_league') }}
)
, golf_members AS
(
    SELECT * from {{ ref('stg_unity_golf_club') }}
)
, companies AS 
(
    SELECT * from {{ ref('stg_companies') }}
)
, combined_members AS
(
    SELECT * from softball_members
    union all
    SELECT * from golf_members
)
, final AS
(
    SELECT
        m.*,
        c.company_name,
        case
            when m.dob > m.last_active then TRUE
            when m.member_since < extract(year from m.dob) then TRUE
            else FALSE
        end as is_suspect_record
    FROM combined_members m
    LEFT JOIN companies c ON m.company_id = c.company_id
)
SELECT * from final