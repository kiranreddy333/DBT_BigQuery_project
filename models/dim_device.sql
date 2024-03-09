{{ config(
    materialized='table',
    schema='google_analytics_sample'
)}}

SELECT DISTINCT
    browser,
    operatingSystem,
    deviceCategory
FROM
    {{ ref('device') }}