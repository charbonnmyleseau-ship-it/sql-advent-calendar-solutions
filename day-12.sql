-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH daily_counts AS (
  SELECT
    DATE(sent_at) AS sent_date, sender_id, 
  COUNT(message_id) AS message_count
  FROM npn_messages
  GROUP BY 1,2
),
daily_ranks AS (
  SELECT *,
  RANK() OVER(partition BY sent_date
  ORDER BY message_count DESC) AS rnk
  FROM daily_counts
)
SELECT *
FROM daily_ranks
WHERE rnk=1
