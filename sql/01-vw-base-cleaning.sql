-- VIEW 01: vw_funnel_base_clean
-- Purpose:
-- Clean and standardize raw user-level funnel data for downstream aggregation.
--
-- What this does:
-- - Standardizes device type into 2 groups; {desktop, mobile}
-- - Ensures step columns are interpretable (timestamps or flags)
-- - Keeps one row per user (or user-session) depending on your raw design
--
-- NOTE:
-- This script assumes raw contains user identifiers + step timestamps (or step flags).
-- If your raw has different column names, update the SELECT mapping below.

CREATE OR REPLACE VIEW `funnel-analysis-483703.funnel_analysis_data.vw_funnel_base_clean` AS
SELECT
  -- Unique user key (adjust if your raw uses a different name)
  CAST(user_id AS STRING) AS user_id,

  -- Standardize device values for consistent grouping in Tableau / analysis
  CASE
    WHEN LOWER(device_type) IN ('desktop', 'web', 'browser') THEN 'desktop'
    WHEN LOWER(device_type) IN ('mobile', 'ios', 'android', 'app') THEN 'mobile'
    ELSE 'unknown'
  END AS device_type,

  -- Step indicators (timestamps preferred; booleans also work)
  -- Replace these fields with your actual raw column names.
  SAFE_CAST(step1_app_open_ts AS TIMESTAMP)   AS step1_app_open_ts,
  SAFE_CAST(step2_content_view_ts AS TIMESTAMP) AS step2_content_view_ts,
  SAFE_CAST(step3_ad_view_ts AS TIMESTAMP)      AS step3_ad_view_ts,
  SAFE_CAST(step4_ad_click_ts AS TIMESTAMP)     AS step4_ad_click_ts,
  SAFE_CAST(step5_purchase_ts AS TIMESTAMP)     AS step5_purchase_ts,

  -- Optional: revenue for purchase events (keep if you have it)
  SAFE_CAST(purchase_amount AS FLOAT64) AS purchase_amount

FROM `funnel-analysis-483703.funnel_analysis_data.raw_funnel_users`;
