{{ config(
    materialized='table',
    schema='google_analytics_sample'
)}}

WITH unnested_main_data AS (
    SELECT
        visitId,
        customDimension.index AS customDimensionIndex,
        customDimension.value AS customDimensionValue
    FROM
        {{ ref('main_data') }},
        UNNEST(customDimensions) AS customDimension
)

-- Define fact table for Google Analytics sessions
SELECT
    main_data.visitId,
    COUNT(*) AS session_count,
    SUM(main_data.totals.visits) AS total_visits,
    SUM(main_data.totals.pageviews) AS total_pageviews,
    SUM(main_data.totals.transactions) AS total_transactions,
    SUM(main_data.totals.transactionRevenue) AS total_transaction_revenue,
    dim_geoNetwork.country,  -- Join with dim_geoNetwork
    dim_device.browser,  -- Join with dim_device
	dim_trafficSource.source,  -- Join with dim_trafficSource
    dim_customDimensions.customDimensionValue  -- Join with dim_customDimensions
FROM
    {{ ref('main_data') }} main_data, unnested_main_data umd

LEFT JOIN
    {{ ref('dim_geoNetwork') }} dim_geoNetwork  -- Join with dim_geoNetwork
ON
    main_data.geoNetwork.country = dim_geoNetwork.country
    AND main_data.geoNetwork.region = dim_geoNetwork.region
    AND main_data.geoNetwork.city = dim_geoNetwork.city
    AND main_data.geoNetwork.networkDomain = dim_geoNetwork.networkDomain

LEFT JOIN
    {{ ref('dim_device') }} dim_device  -- Join with dim_device
ON
    main_data.device.browser = dim_device.browser
    AND main_data.device.operatingSystem = dim_device.operatingSystem
    AND main_data.device.deviceCategory = dim_device.deviceCategory

LEFT JOIN
    {{ ref('dim_trafficSource') }} dim_trafficSource  -- Join with dim_trafficSource
ON
     main_data.trafficSource.source = dim_trafficSource.source
    AND main_data.trafficSource.medium = dim_trafficSource.medium
    AND main_data.trafficSource.campaign = dim_trafficSource.campaign
    AND main_data.trafficSource.referralPath = dim_trafficSource.referralPath

LEFT JOIN
    {{ ref('dim_customDimensions') }} dim_customDimensions  -- Join with dim_device
ON
    umd.customDimensionIndex = dim_customDimensions.customDimensionIndex
    AND umd.customDimensionValue = dim_customDimensions.customDimensionValue

GROUP BY
    main_data.visitId, dim_geoNetwork.country, dim_device.browser, dim_trafficSource.source , dim_customDimensions.customDimensionValue