# 'Cool T-Shirts' touch attribution analysis
CoolTShirts sells all kinds of cool T-shirts. They’ve launched marketing campaigns to boost visits and sales, and now want to map the customer journey using touch attribution. This project will guide you through analyzing user data to help optimize their campaigns.

# 📘 Project Overview

You're analyzing how users interact with the CoolTShirts website—from first visit to purchase—using touch attribution. The schema involves a `page_visits` table that includes:

- `user_id`
- `timestamp`
- `page_name`
- `utm_source`
- `utm_campaign`

You'll write several SQL queries to analyze campaign effectiveness. You can see the queries here: [attribution-queries](https://github.com/jessfss/attribution-queries/blob/main/queries.sql)

# 📊 Campaign Investment Recommendation
### CoolTShirts – Attribution Analysis Summary

---

## ✅ Top 5 Campaigns to Reinvest In

| Rank | Source     | Campaign                          | Purchases |
|------|------------|-----------------------------------|-----------|
| 1    | Email      | Weekly Newsletter                 | **115**   |
| 2    | Facebook   | Retargeting Ad                    | **113**   |
| 3    | Email      | Retargeting Campaign              | **54**    |
| 4    | Google     | Paid Search                       | **52**    |
| 5    | Buzzfeed   | 10 Crazy Cool T-Shirts Facts      | **9**     |

---

## 💡 Insights

- **Email campaigns dominate**, responsible for nearly 45% of all last-touch purchases.
- **Retargeting is highly effective**, particularly through Facebook and email.
- **Google Paid Search** captures high-intent traffic and converts well.
- **Content marketing channels** like Buzzfeed show potential but need optimization.

---

## 🔍 Methodology

### 📌 Last-Touch Attribution on Purchase Page

To identify the campaigns most responsible for purchases, we used the **last-touch attribution model** with the following SQL:

```sql
WITH last_touch AS (
  SELECT user_id,
         MAX(timestamp) AS last_touch_at
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
SELECT utm_source,
       utm_campaign,
       COUNT(*) AS last_purchase_touch_count
FROM lt_attr
GROUP BY utm_source, utm_campaign
ORDER BY last_purchase_touch_count DESC;

```

#### Acknowledgements: This is a project completed as part of 'Analysing data with SQL' course on Codecademy.


