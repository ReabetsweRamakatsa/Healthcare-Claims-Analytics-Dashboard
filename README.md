# Healthcare-Claims-Analytics-Dashboard
Data analysis and Power BI dashboard to identify high-cost healthcare drivers and margin leakage for a health insurance provider.
# Health Insurance Claims Analysis
## Project Overview
The goal of this project is to analyze synthetic claims data to understand why the company is losing money. 

### Key Business Questions Addressed:
* Which claim types are most expensive? 
* Which CPT/ICD codes drive the highest spending?
* Which members account for the largest share of costs?
* Comparison of billed vs. paid amounts. 

# Key Analytical Insights
# 1. High-Intensity Cost Drivers
The data confirms that Inpatient claims are the primary driver of financial volume.

Cost Disparity: The "Avg Cost per Member" for Inpatient services is significantly higher (near R10k) compared to Pharmacy or Lab services, which hover near R0k.

Volume vs. Value: While Inpatient services likely have lower frequency than Pharmacy, they account for the lion's share of the total spend (R1.07M paid out of R1.53M total).

# 2. Payment Ratio & Margin Analysis
The "Payment Ratio" (Total Paid / Total Billed) acts as a proxy for contractual adjustments and claim denials.

Best/Worst Recovery: Lab (0.91) and Pharmacy (0.89) have the highest payment ratios, suggesting these are highly standardized, pre-approved costs.

Inpatient Friction: Inpatient claims have the lowest ratio (0.74). This indicates a 26% "haircut" on billed amounts, likely due to negotiated provider discounts or more frequent claim denials in complex care.

# 3. Plan Type Performance
The "Payment Ratio by plan_type" shows a very tight distribution (ranging from approx. 0.68 to 0.77).

HMO leads in payment efficiency (0.77), while POS shows the lowest efficiency (0.68). This suggests that more restrictive plans (HMO) may have better-aligned billing practices than flexible plans (POS).

# 4. Member Utilization (Pareto Principle)
The "Total Paid by member_id" donut chart suggests a relatively even distribution among the top 7 members, with Member #6 being the highest contributor (17.96%).

# Insight: 
There isn't a single "catastrophic" outlier member; rather, a small group of high-utilizers (Member IDs 6, 32, and 82) accounts for nearly 50% of the top-tier spend.

### Tools Used
* **SQL (MySQL)**: Advanced CTEs and Window Functions for data extraction.
* **Power BI**: Data modeling (Star Schema) and DAX for Margin Analysis.
