{{ config(
    materialized='table',
    schema='google_analytics_sample'
)}}

-- Unnest the `geoNetwork` column to access its nested fields
WITH unnested_data AS (
    SELECT
        *,
        geoNetwork.*  -- Unnesting the `geoNetwork` column to access its nested fields
    FROM
        {{ ref('main_data') }},
        UNNEST([geoNetwork]) AS geoNetwork
)

-- Select the nested fields from the unnested data
SELECT
    visitId,
    geoNetwork.continent,
    geoNetwork.subContinent,
    geoNetwork.country,
    geoNetwork.region,
    geoNetwork.metro,
    geoNetwork.city,
    geoNetwork.cityId,
    geoNetwork.networkDomain,
    geoNetwork.latitude,
    geoNetwork.longitude,
    geoNetwork.networkLocation
FROM
    unnested_data
WHERE
    geoNetwork IS NOT NULL