/*
Q: what are the top-payinh data analyst jobs?
-Identify the top 10 highest paying data analyst roles that are available remotely.
- Focuses on job postings wiyh specified salaries (remove nulls).
- Why? Highlight the top paying opportunities for data analysts, offering insights into 
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
AND
    job_location = 'Anywhere'
AND 
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;

