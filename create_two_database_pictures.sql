create_two_database_pictures.sql

WITH periode AS (
SELECT ARRAY(
    SELECT
        CURRENT_DATE(),
    UNION ALL
    SELECT
        DATE_SUB(CURRENT_DATE(), INTERVAL 1 WEEK)
    ORDER BY 1 ) AS update_time
)
,

orders AS   (
SELECT 5 as order_id,
      "2023-01-02" as order_date,
UNION ALL
SELECT 6 as order_id,
      "2023-04-26" as order_date,
  )

SELECT
    orders.*,start_date,
    CASE
      WHEN start_date= update_time[OFFSET(0)]  THEN "S-1"
      WHEN start_date= update_time[OFFSET(1)] THEN "S"
      ELSE NULL
    END AS Sem
FROM
    orders
-- left join: only the condition is fullfilled then the join will be proceced. Cross join will make the join then  filter the condtion. Hence Left Join is more performant
LEFT JOIN
    (SELECT *
     FROM
        periode,
        UNNEST(update_time) AS start_date)
    ON CAST(orders.order_date AS DATE) <= start_date
--   CROSS JOIN
--       periode,
--       UNNEST(update_time) AS start_date
--   WHERE CAST(orders.order_date AS DATE) <= start_date




