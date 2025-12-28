-- SQL Advent Calendar - Day 3
-- Title: The Grinch's Best Pranks Per Target
-- Difficulty: hard
--
-- Question:
-- The Grinch has brainstormed a ton of pranks for Whoville, but he only wants to keep the top prank per target, with the highest evilness score. Return the most evil prank for each target. If two pranks have the same evilness, the more recently brainstormed wins.
--
-- The Grinch has brainstormed a ton of pranks for Whoville, but he only wants to keep the top prank per target, with the highest evilness score. Return the most evil prank for each target. If two pranks have the same evilness, the more recently brainstormed wins.
--

-- Table Schema:
-- Table: grinch_prank_ideas
--   prank_id: INTEGER
--   target_name: VARCHAR
--   prank_description: VARCHAR
--   evilness_score: INTEGER
--   created_at: TIMESTAMP
--

-- My Solution:

SELECT
    target_name,
    prank_description,
    evilness_score
FROM
    (
        SELECT
            target_name,
            prank_description,
            evilness_score,
            created_at,
            -- Assign a rank to each prank within its target group
            -- 1. ORDER BY evilness_score DESC (highest score first)
            -- 2. Then by created_at DESC (most recent first, for the tie-breaker)
            ROW_NUMBER() OVER (
                PARTITION BY target_name
                ORDER BY evilness_score DESC, created_at DESC
            ) as rn
        FROM
            grinch_prank_ideas
    ) as ranked_pranks
WHERE
    -- Select only the top-ranked prank (rn = 1) for each target
    rn = 1
ORDER BY
    evilness_score DESC;
