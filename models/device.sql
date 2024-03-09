{{ config(
    materialized='table',
    schema='google_analytics_sample'
)}}

-- Unnest the `device` column to access its nested fields
WITH unnested_data AS (
    SELECT
        *,
        device.*  -- Unnesting the `device` column to access its nested fields
    FROM
        {{ ref('main_data') }},
        UNNEST([device]) AS device
)

-- Select the nested fields from the unnested data
SELECT
    visitId,
    device.browser,
	device.browserVersion,
	device.browserSize,
    device.operatingSystem,
	device.operatingSystemVersion,
    device.ismobile,
    device.mobileDeviceBranding,
    device.mobileDeviceModel,
    device.mobileInputSelector,
    device.mobileDeviceInfo,
    device.mobileDeviceMarketingName,
    device.flashVersion,
    device.javaEnabled,
    device.language,
    device.screenColors,
    device.screenResolution,
    device.deviceCategory
FROM
    unnested_data
WHERE
    device IS NOT NULL