WITH combined_members AS (
    SELECT * FROM {{ ref('int_combined_members') }}
)

SELECT *
FROM combined_members
WHERE dob > CURRENT_DATE
    OR dob > CURRENT_DATE
    OR dob > last_active
