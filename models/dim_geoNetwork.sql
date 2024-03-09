{{ config(
    materialized='table',
    schema='google_analytics_sample'
)}}

SELECT DISTINCT
    country,
    region,
    city,
    networkDomain
FROM
    {{ ref('geoNetwork') }}