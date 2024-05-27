SELECT
    job_schedule_type,
    AVG(salary_year_avg) AS yearly_salary_average,
    AVG(salary_hour_avg) AS hourly_salary_average
FROM
    job_postings_fact
WHERE 
    job_posted_date >= '2023-06-01'
GROUP BY
    job_schedule_type;


SELECT * FROM job_postings_fact
LIMIT 20;

SELECT
    COUNT(job_id) AS num_job_posted,
    EXTRACT(MONTH FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST')) as month
FROM 
    job_postings_fact
GROUP BY
    month
ORDER BY
    month;


SELECT
    company_dim.company_id,
    company_dim.name,
    job_postings_fact.job_health_insurance
FROM company_dim
LEFT JOIN 
job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
WHERE
    EXTRACT(YEAR FROM job_posted_date) = 2023
    AND EXTRACT(QUARTER FROM job_posted_date) = 2
    AND job_postings_fact.job_health_insurance = 'TRUE';


---- creating tables from other tables

CREATE TABLE jan_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    LIMIT 10;

CREATE TABLE feb_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2
    LIMIT 10;

CREATE TABLE mar_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3
    LIMIT 10;

-- creating a third column that says if a job is remote, onsite or localA
SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' then 'remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
GROUP BY location_category;

SELECT * 
FROM skills_dim;

SELECT * 
FROM skills_job_dim
LIMIT 300;

WITH skills_count AS (
    SELECT skill_id,
    COUNT(*) as appearance
    FROM skills_job_dim
    GROUP BY skill_id
)

SELECT 
    skills_dim.skills AS Skill,
    skills_count.appearance AS num_job_required
FROM skills_dim
LEFT JOIN skills_count ON skills_dim.skill_id = skills_count.skill_id
ORDER BY num_job_required DESC




