{{ config(
    materialized='table',
    schema='google_analytics_sample'
)}}

-- Unnest the `totals` column to access its nested fields
WITH unnested_data AS (
    SELECT
        *,
        totals.*  -- Unnesting the `totals` column to access its nested fields
    FROM
        {{ ref('main_data') }},
        UNNEST([totals]) AS totals
)

-- Select the nested fields from the unnested data
SELECT
    visitId,
    totals.visits,
    totals.hits,
    totals.pageviews,
    totals.timeOnSite,
    totals.bounces,
    totals.transactions,
    totals.transactionRevenue,
    totals.newvisits,
    totals.screenviews,
    totals.uniqueScreenviews,
    totals.timeOnScreen,
    totals.totalTransactionRevenue,
    totals.sessionQualityDim
FROM
    unnested_data
WHERE
    totals IS NOT NULL