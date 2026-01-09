-- VIEW 03: vw_funnel_long
-- Purpose:
-- Create a long-format table for visualization:
-- One row per (Device Type, Step) with a user count.
--
-- Why this matters:
-- Tableau works extremely well with "long" data for funnels,
-- letting you place Step on Rows/Columns and compare device segments easily.

CREATE OR REPLACE VIEW `funnel-analysis-483703.funnel_analysis_data.vw_funnel_long` AS
WITH device_summary AS (
  SELECT
    `Device Type` AS device_type,
    `Users Step1 App Open` AS users_step1,
    `Users Step2 Content View` AS users_step2,
    `Users Step3 Ad View` AS users_step3,
    `Users Step4 Ad Click` AS users_step4,
    `Users Step5 Purchase` AS users_step5
  FROM `funnel-analysis-483703.funnel_analysis_data.vw_funnel_device_summary`
),
unpivoted AS (
  SELECT device_type, 1 AS step_order, 'Awareness'    AS step_name, users_step1 AS users FROM device_summary
  UNION ALL
  SELECT device_type, 2 AS step_order, 'Content View' AS step_name, users_step2 AS users FROM device_summary
  UNION ALL
  SELECT device_type, 3 AS step_order, 'Ad Click'     AS step_name, users_step3 AS users FROM device_summary
  UNION ALL
  SELECT device_type, 4 AS step_order, 'Checkout'     AS step_name, users_step4 AS users FROM device_summary
  UNION ALL
  SELECT device_type, 5 AS step_order, 'Purchase'     AS step_name, users_step5 AS users FROM device_summary
)

SELECT
  device_type AS `Device Type`,
  step_order  AS `Step Order`,
  step_name   AS `Step Name`,
  users       AS `Users`
FROM unpivoted;
