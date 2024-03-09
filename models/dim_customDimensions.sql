{{ config(
    materialized='table',
    schema='google_analytics_sample'
)}}

SELECT DISTINCT
    customDimensionIndex,
    customDimensionValue
FROM
    {{ ref('customDimensions') }}