USE health;
-- 1. Cost Contribution by Claim Type

WITH TotalSpend AS (
    SELECT SUM(paid_amount) AS grand_total FROM claims
)
SELECT 
    c.claim_type,
    SUM(c.paid_amount) AS total_paid,
    ROUND((SUM(c.paid_amount) / ts.grand_total) * 100, 2) AS pct_of_total_spend
FROM claims c, TotalSpend ts
GROUP BY c.claim_type, ts.grand_total
ORDER BY total_paid DESC;

-- 2. High-Cost Code Identification (Top 1% Analysis)
WITH CodeSpending AS (
    SELECT 
        cpt_code,
        icd_code,
        SUM(paid_amount) AS total_spent,
        DENSE_RANK() OVER (ORDER BY SUM(paid_amount) DESC) AS cost_rank
    FROM claims
    GROUP BY cpt_code, icd_code
)
SELECT * FROM CodeSpending 
WHERE cost_rank <= 10;

-- 3. Pareto Analysis of Member Spending (The 80/20 Rule)
WITH MemberAggregates AS (
    SELECT 
        member_id,
        SUM(paid_amount) AS member_total_paid,
        SUM(SUM(paid_amount)) OVER() AS company_total_paid
    FROM claims
    GROUP BY member_id
),
MemberRanking AS (
    SELECT 
        m.member_id,
        ma.member_total_paid,
        (ma.member_total_paid / ma.company_total_paid) * 100 AS pct_contribution,
        SUM(ma.member_total_paid) OVER(ORDER BY ma.member_total_paid DESC) / ma.company_total_paid AS cumulative_pct
    FROM MemberAggregates ma
    JOIN members m ON ma.member_id = m.member_id
)
SELECT * FROM MemberRanking 
WHERE cumulative_pct <= 0.80; -- Shows members contributing to the first 80% of costs

-- 4. Billed vs. Paid "Leakage" Analysis
SELECT 
    claim_type,
    avg_billed,
    avg_paid,
    (avg_paid / avg_billed) AS payment_ratio
FROM (
    SELECT 
        claim_type,
        AVG(billed_amount) AS avg_billed,
        AVG(paid_amount) AS avg_paid
    FROM claims
    GROUP BY claim_type
) AS internal_metrics
ORDER BY payment_ratio DESC;

-- 