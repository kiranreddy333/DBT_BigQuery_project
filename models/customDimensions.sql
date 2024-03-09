{{ config(
    materialized='table',
    schema='google_analytics_sample'
)}}

-- Unnest the `customDimensions` column to access its nested fields
WITH unnested_data AS (
    SELECT
        *,
        cd.index AS customDimensionIndex,  -- Explicitly alias the index column
        cd.value AS customDimensionValue  -- Alias the value column
    FROM
        {{ ref('main_data') }},
        UNNEST(customDimensions) AS cd
)

-- Select the nested fields from the unnested data
SELECT
    visitId,
    customDimensionIndex,  -- Use the aliased column name
    customDimensionValue  -- Use the aliased column name
FROM
    unnested_data
WHERE
    customDimensions IS NOT NULL