-- DATA QUALITY CHECKS
-- Purpose:
-- Quick checks you can run to validate the funnel is coherent.
-- These are great to include in a GitHub repo because they show analytical rigor.

-- 1) Confirm only expected device types
SELECT
  device_type,
  COUNT(*) AS rows
FROM `funnel-analysis-483703.funnel_analysis_data.vw_funnel_base_clean`
GROUP BY device_type
ORDER BY rows DESC;

-- 2) Funnel monotonicity sanity check (counts should generally decrease by step within device)
-- This uses the long view and compares step counts.
WITH ordered AS (
  SELECT
    `Device Type`,
    `Step Order`,
    `Users`,
    LAG(`Users`) OVER (PARTITION BY `Device Type` ORDER BY `Step Order`) AS prev_users
  FROM `funnel-analysis-483703.funnel_analysis_data.vw_funnel_long`
)
SELECT
  *,
  CASE
    WHEN prev_users IS NULL THEN 'first step'
    WHEN `Users` <= prev_users THEN 'ok'
    ELSE 'warning: increased'
  END AS monotonic_check
FROM ordered
ORDER BY `Device Type`, `Step Order`;

-- 3) Check for users with purchase but missing earlier steps (data integrity)
-- If your data is perfectly tracked, purchase should imply earlier steps.
SELECT
  device_type,
  COUNT(DISTINCT user_id) AS users_purchase_without_step1
FROM `funnel-analysis-483703.funnel_analysis_data.vw_funnel_base_clean`
WHERE step5_purchase_ts IS NOT NULL
  AND step1_app_open_ts IS NULL
GROUP BY device_type;
