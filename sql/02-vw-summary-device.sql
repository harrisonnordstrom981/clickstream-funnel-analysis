-- VIEW 02: vw_funnel_device_summary
-- Purpose:
-- Produce a device-level funnel summary table:
-- - Users at each step (distinct users reaching that step)
-- - Step-to-step conversion rates
-- - Overall purchase rate
--
-- Logic:
-- A user is counted in a step if that step timestamp is NOT NULL.
-- (If you use booleans, replace "IS NOT NULL" with "= TRUE".)

CREATE OR REPLACE VIEW `funnel-analysis-483703.funnel_analysis_data.vw_funnel_device_summary` AS
WITH step_counts AS (
  SELECT
    device_type,

    -- Distinct users reaching each step
    COUNT(DISTINCT IF(step1_app_open_ts   IS NOT NULL, user_id, NULL)) AS users_step1_app_open,
    COUNT(DISTINCT IF(step2_content_view_ts IS NOT NULL, user_id, NULL)) AS users_step2_content_view,
    COUNT(DISTINCT IF(step3_ad_view_ts      IS NOT NULL, user_id, NULL)) AS users_step3_ad_view,
    COUNT(DISTINCT IF(step4_ad_click_ts     IS NOT NULL, user_id, NULL)) AS users_step4_ad_click,
    COUNT(DISTINCT IF(step5_purchase_ts     IS NOT NULL, user_id, NULL)) AS users_step5_purchase

  FROM `funnel-analysis-483703.funnel_analysis_data.vw_funnel_base_clean`
  WHERE device_type IN ('desktop', 'mobile')  -- keep analysis clean
  GROUP BY device_type
)

SELECT
  device_type AS `Device Type`,

  -- Step counts (these match what you used in Tableau)
  users_step1_app_open     AS `Users Step1 App Open`,
  users_step2_content_view AS `Users Step2 Content View`,
  users_step3_ad_view      AS `Users Step3 Ad View`,
  users_step4_ad_click     AS `Users Step4 Ad Click`,
  users_step5_purchase     AS `Users Step5 Purchase`,

  -- Step-to-step conversion rates
  -- SAFE_DIVIDE prevents errors when denominators are zero.
  SAFE_DIVIDE(users_step2_content_view, users_step1_app_open) AS `Step1 To Step2 Rate`,
  SAFE_DIVIDE(users_step3_ad_view,      users_step2_content_view) AS `Step2 To Step3 Rate`,
  SAFE_DIVIDE(users_step4_ad_click,     users_step3_ad_view) AS `Step3 To Step4 Rate`,
  SAFE_DIVIDE(users_step5_purchase,     users_step4_ad_click) AS `Step4 To Step5 Rate`,

  -- Overall purchase rate from initial step
  SAFE_DIVIDE(users_step5_purchase, users_step1_app_open) AS `Overall Purchase Rate`

FROM step_counts;
