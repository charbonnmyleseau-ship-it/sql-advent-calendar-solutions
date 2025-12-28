-- SQL Advent Calendar - Day 6
-- Title: Ski Resort Snowfall Rankings
-- Difficulty: hard
--
-- Question:
-- Buddy is planning a winter getaway and wants to rank ski resorts by annual snowfall. Can you help him bucket these ski resorts into quartiles?
--
-- Buddy is planning a winter getaway and wants to rank ski resorts by annual snowfall. Can you help him bucket these ski resorts into quartiles?
--

-- Table Schema:
-- Table: resort_monthly_snowfall
--   resort_id: INT
--   resort_name: VARCHAR
--   snow_month: INT
--   snowfall_inches: DECIMAL
--

-- My Solution:

SELECT
    yearly.resort_name,
    yearly.totalsnow, -- Total annual snowfall in inches
    NTILE(4) OVER (ORDER BY totalsnow DESC) as quartile_rank,
    CASE
        WHEN NTILE(4) OVER (ORDER BY totalsnow DESC) = 1 THEN 'Top 25% (Heaviest Snowfall)'
        WHEN NTILE(4) OVER (ORDER BY totalsnow DESC) = 2 THEN 'Upper Middle 25%'
        WHEN NTILE(4) OVER (ORDER BY totalsnow DESC) = 3 THEN 'Lower Middle 25%'
        ELSE 'Bottom 25% (Lightest Snowfall)'
    END as snowfall_range
FROM
    -- Subquery to calculate the total annual snowfall for each resort
    (SELECT
        resort_name,
        SUM(snowfall_inches) AS totalsnow
    FROM
        resort_monthly_snowfall
    GROUP BY
        resort_name
    ) AS yearly
ORDER BY
    quartile_rank ASC;
