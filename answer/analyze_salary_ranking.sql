--CTE
WITH department_avg AS (
  SELECT
    d.id AS department_id,
    d.name AS department_name,
    ROUND(AVG(e.salary)) AS department_avg_salary
  FROM
    departments d
    JOIN employees e ON d.id = e.department_id
  GROUP BY
    d.id, d.name
)
SELECT * FROM department_avg;

--VIEW
CREATE VIEW employee_salary_analysis AS
WITH department_avg AS (
  SELECT
    d.id AS department_id,
    d.name AS department_name,
    ROUND(AVG(e.salary)) AS department_avg_salary
  FROM
    departments d
    JOIN employees e ON d.id = e.department_id
  GROUP BY
    d.id, d.name
)
SELECT
  da.department_name,
  e.name AS employee_name,
  e.salary,
  da.department_avg_salary,
  RANK() OVER (PARTITION BY da.department_name ORDER BY e.salary DESC) AS salary_rank_in_department
FROM
  employees e
  JOIN department_avg da ON e.department_id = da.department_id
ORDER BY
  da.department_name,
  salary_rank_in_department;
SELECT * FROM employee_salary_analysis;