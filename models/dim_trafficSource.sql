{{ config(
    materialized='table',
    schema='google_analytics_sample'
)}}

SELECT DISTINCT
    referralPath,
    campaign,
    source,
    medium
FROM
    {{ ref('trafficSource') }}