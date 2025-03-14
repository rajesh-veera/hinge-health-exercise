{{ config(error_if = '>50') }}

WITH combined_members AS (
    SELECT * FROM {{ ref('int_members') }}
),

valid_states AS (
    SELECT * FROM (VALUES
        ('AL'), ('AK'), ('AZ'), ('AR'), ('CA'), ('CO'), ('CT'), ('DE'), ('FL'), ('GA'),
        ('HI'), ('ID'), ('IL'), ('IN'), ('IA'), ('KS'), ('KY'), ('LA'), ('ME'), ('MD'),
        ('MA'), ('MI'), ('MN'), ('MS'), ('MO'), ('MT'), ('NE'), ('NV'), ('NH'), ('NJ'),
        ('NM'), ('NY'), ('NC'), ('ND'), ('OH'), ('OK'), ('OR'), ('PA'), ('RI'), ('SC'),
        ('SD'), ('TN'), ('TX'), ('UT'), ('VT'), ('VA'), ('WA'), ('WV'), ('WI'), ('WY')
    ) AS states(state_code)
)

SELECT *
FROM combined_members
WHERE state NOT IN (SELECT state_code FROM valid_states)
