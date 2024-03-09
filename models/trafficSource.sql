{{ config(
    materialized='table',
    schema='google_analytics_sample'
)}}

-- Unnest the `trafficSource` column to access its nested fields
WITH unnested_data AS (
    SELECT
        *,
        trafficSource.*  -- Unnesting the `trafficSource` column to access its nested fields
    FROM
        {{ ref('main_data') }},
        UNNEST([trafficSource]) AS trafficSource
)

-- Select the nested fields from the unnested data
SELECT
    visitId,
    trafficSource.referralPath,
    trafficSource.campaign,
    trafficSource.source,
    trafficSource.medium,
    trafficSource.keyword,
    trafficSource.adContent,
	trafficSource.adwordsClickInfo.campaignId,
    trafficSource.adwordsClickInfo.adGroupId,
    trafficSource.adwordsClickInfo.creativeId,
    trafficSource.adwordsClickInfo.criteriaid,
    trafficSource.adwordsClickInfo.page,
    trafficSource.adwordsClickInfo.slot,
    trafficSource.adwordsClickInfo.criteriaParameters,
    trafficSource.adwordsClickInfo.gclId,
    trafficSource.adwordsClickInfo.customerId,
    trafficSource.adwordsClickInfo.adNetworkType,
    trafficSource.adwordsClickInfo.isVideoAd,
    trafficSource.istrueDirect,
    trafficSource.campaignCode
FROM
    unnested_data
WHERE
    trafficSource IS NOT NULL