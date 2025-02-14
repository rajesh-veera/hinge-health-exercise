{% macro state_to_abbreviation(state_column) %}
    CASE 
        WHEN {{ state_column }} ILIKE 'Alabama' THEN 'AL'
        WHEN {{ state_column }} ILIKE 'Alaska' THEN 'AK'
        WHEN {{ state_column }} ILIKE 'Arizona' THEN 'AZ'
        WHEN {{ state_column }} ILIKE 'Arkansas' THEN 'AR'
        WHEN {{ state_column }} ILIKE 'California' THEN 'CA'
        WHEN {{ state_column }} ILIKE 'Colorado' THEN 'CO'
        WHEN {{ state_column }} ILIKE 'Connecticut' THEN 'CT'
        WHEN {{ state_column }} ILIKE 'Delaware' THEN 'DE'
        WHEN {{ state_column }} ILIKE 'Florida' THEN 'FL'
        WHEN {{ state_column }} ILIKE 'Georgia' THEN 'GA'
        WHEN {{ state_column }} ILIKE 'Hawaii' THEN 'HI'
        WHEN {{ state_column }} ILIKE 'Idaho' THEN 'ID'
        WHEN {{ state_column }} ILIKE 'Illinois' THEN 'IL'
        WHEN {{ state_column }} ILIKE 'Indiana' THEN 'IN'
        WHEN {{ state_column }} ILIKE 'Iowa' THEN 'IA'
        WHEN {{ state_column }} ILIKE 'Kansas' THEN 'KS'
        WHEN {{ state_column }} ILIKE 'Kentucky' THEN 'KY'
        WHEN {{ state_column }} ILIKE 'Louisiana' THEN 'LA'
        WHEN {{ state_column }} ILIKE 'Maine' THEN 'ME'
        WHEN {{ state_column }} ILIKE 'Maryland' THEN 'MD'
        WHEN {{ state_column }} ILIKE 'Massachusetts' THEN 'MA'
        WHEN {{ state_column }} ILIKE 'Michigan' THEN 'MI'
        WHEN {{ state_column }} ILIKE 'Minnesota' THEN 'MN'
        WHEN {{ state_column }} ILIKE 'Mississippi' THEN 'MS'
        WHEN {{ state_column }} ILIKE 'Missouri' THEN 'MO'
        WHEN {{ state_column }} ILIKE 'Montana' THEN 'MT'
        WHEN {{ state_column }} ILIKE 'Nebraska' THEN 'NE'
        WHEN {{ state_column }} ILIKE 'Nevada' THEN 'NV'
        WHEN {{ state_column }} ILIKE 'New Hampshire' THEN 'NH'
        WHEN {{ state_column }} ILIKE 'New Jersey' THEN 'NJ'
        WHEN {{ state_column }} ILIKE 'New Mexico' THEN 'NM'
        WHEN {{ state_column }} ILIKE 'New York' THEN 'NY'
        WHEN {{ state_column }} ILIKE 'North Carolina' THEN 'NC'
        WHEN {{ state_column }} ILIKE 'North Dakota' THEN 'ND'
        WHEN {{ state_column }} ILIKE 'Ohio' THEN 'OH'
        WHEN {{ state_column }} ILIKE 'Oklahoma' THEN 'OK'
        WHEN {{ state_column }} ILIKE 'Oregon' THEN 'OR'
        WHEN {{ state_column }} ILIKE 'Pennsylvania' THEN 'PA'
        WHEN {{ state_column }} ILIKE 'Rhode Island' THEN 'RI'
        WHEN {{ state_column }} ILIKE 'South Carolina' THEN 'SC'
        WHEN {{ state_column }} ILIKE 'South Dakota' THEN 'SD'
        WHEN {{ state_column }} ILIKE 'Tennessee' THEN 'TN'
        WHEN {{ state_column }} ILIKE 'Texas' THEN 'TX'
        WHEN {{ state_column }} ILIKE 'Utah' THEN 'UT'
        WHEN {{ state_column }} ILIKE 'Vermont' THEN 'VT'
        WHEN {{ state_column }} ILIKE 'Virginia' THEN 'VA'
        WHEN {{ state_column }} ILIKE 'Washington' THEN 'WA'
        WHEN {{ state_column }} ILIKE 'West Virginia' THEN 'WV'
        WHEN {{ state_column }} ILIKE 'Wisconsin' THEN 'WI'
        WHEN {{ state_column }} ILIKE 'Wyoming' THEN 'WY'
        ELSE NULL
    END
{% endmacro %}