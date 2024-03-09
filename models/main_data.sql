{{ config(
    materialized='table',
    schema='google_analytics_sample'
)}}

select
  visitorId,
  visitNumber, 
  visitId,
  visitStartTime,
  date,
  totals,
  trafficSource,
  device,
  geoNetwork,
  customDimensions,
  hits,
  fullVisitorId,
  userId,
  clientId,
  channelGrouping,
  socialEngagementType
from level-oxygen-416407.google_analytics_sample.ga_sessions_20170801