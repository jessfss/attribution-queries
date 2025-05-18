/*
Here's the first-touch query, in case you need it
*/

/*
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp;
    */
-- Task 1. How many campaigns and sources does CoolTShirts use? Which source is used for each campaign?

-- Use three queries:

-- one for the number of distinct campaigns,
-- one for the number of distinct sources,
-- one to find how they are related.


-- Number of distinct campaigns
--SELECT COUNT(DISTINCT utm_campaign) FROM page_visits;

-- Number of distinct sources
--SELECT COUNT(DISTINCT utm_source) FROM page_visits;

-- Campaign-source mapping
--SELECT DISTINCT utm_campaign, utm_source FROM page_visits;


-- Task 2. What pages are on the CoolTShirts website? Find the distinct values of the page_name column.

-- SELECT DISTINCT page_name FROM page_visits;

-- Task 3. How many first touches is each campaign responsible for? You’ll need to use a first-touch query. Group by campaign and count the number of first touches for each.

/*
WITH first_touch AS (
  SELECT user_id, MIN(timestamp) AS first_touch_at
  FROM page_visits
  GROUP BY user_id
),
ft_attr AS (
  SELECT ft.user_id,
         ft.first_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv
    ON ft.user_id = pv.user_id
   AND ft.first_touch_at = pv.timestamp
)
SELECT utm_campaign, COUNT(*) AS first_touch_count
FROM ft_attr
GROUP BY utm_campaign
ORDER BY first_touch_count DESC;
*/

--Task 4. How many last touches is each campaign responsible for?

/*
WITH last_touch AS (
  SELECT user_id, MAX(timestamp) AS last_touch_at
  FROM page_visits
  GROUP BY user_id
),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
   AND lt.last_touch_at = pv.timestamp
)
SELECT utm_campaign, COUNT(*) AS last_touch_count
FROM lt_attr
GROUP BY utm_campaign
ORDER BY last_touch_count DESC;
*/

-- Task 5. How many visitors make a purchase? Count the distinct users who visited the page named 4 - purchase.

/*
SELECT COUNT(DISTINCT user_id)
FROM page_visits
WHERE page_name = '4 - purchase';
*/

-- Task 6. How many last touches on the purchase page is each campaign responsible for? This query will look similar to your last-touch query, but with an additional WHERE clause.

/*
WITH last_touch AS (
  SELECT user_id, MAX(timestamp) AS last_touch_at
  FROM page_visits
  WHERE page_name = '4 - purchase'
  GROUP BY user_id
),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
   AND lt.last_touch_at = pv.timestamp
)
SELECT utm_campaign, COUNT(*) AS last_purchase_touch_count
FROM lt_attr
GROUP BY utm_campaign
ORDER BY last_purchase_touch_count DESC;
*/

-- Task 7. CoolTShirts can re-invest in 5 campaigns. Given your findings in the project, which should they pick and why?

/*
Top 5 Campaigns to Reinvest In
CoolTShirts should reinvest in the following top 5 performing campaigns, as they are responsible for the highest number of last touches leading to purchases:

1 Email – weekly-newsletter (115 purchases)

  Strongest performer; likely retains loyal or subscribed customers.

2 Facebook – retargetting-ad (113 purchases)

  Very close second; retargeting ads appear highly effective for conversion.

3 Email – retargetting-campaign (54 purchases)

  Also a retargeting tactic; shows that email remarketing works well.

4 Google – paid-search (52 purchases)

  Solid organic lead generation via paid intent-based traffic.

5 Buzzfeed – ten-crazy-cool-tshirts-facts (9 purchases)

  Despite a steep drop-off, this content-driven campaign still outperformed other media partnerships.

Strategic Recommendation

Focus on email and retargeting strategies, which account for over 60% of attributed purchases.

Keep Google paid search active—it brings in buyers with clear intent.

Experiment further with content marketing like Buzzfeed, but only if costs are low, as ROI is currently marginal.
*/
