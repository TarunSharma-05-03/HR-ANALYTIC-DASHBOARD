-- Validation Queries
-- I ran these queries after importing the data to make sure
-- everything looks correct before building the dashboard.

-- Check 1: Total rows should be 1470
SELECT COUNT(*) AS TotalRows 
FROM dbo.HR_Analytics;


-- Check 2: No employee should have a missing ID
SELECT COUNT(*) AS NullEmpID 
FROM dbo.HR_Analytics 
WHERE EmpID IS NULL;


-- Check 3: Check for missing values in important columns
SELECT
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END)            AS Missing_Age,
    SUM(CASE WHEN Attrition IS NULL THEN 1 ELSE 0 END)      AS Missing_Attrition,
    SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END)     AS Missing_Department,
    SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END)  AS Missing_Income,
    SUM(CASE WHEN YearsAtCompany IS NULL THEN 1 ELSE 0 END) AS Missing_Years
FROM dbo.HR_Analytics;
-- All values should be 0


-- Check 4: Only 3 departments should exist
SELECT DISTINCT Department 
FROM dbo.HR_Analytics
ORDER BY Department;
-- Human Resources, Research & Development, Sales


-- Check 5: Attrition column should have Yes and No only
-- If it shows 1 and 0 then there is an import issue
SELECT DISTINCT Attrition 
FROM dbo.HR_Analytics;


-- Check 6: Department summary to match with dashboard numbers
SELECT
    ISNULL(Department, 'All Departments') AS Department,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0 END) 
        / COUNT(*) * 100, 1
    ) AS AttritionRate
FROM dbo.HR_Analytics
GROUP BY GROUPING SETS ((Department), ());
-- All Departments : 1470 employees, 237 left, 16.1%
-- Sales           : 446  employees, 92  left, 20.6%
-- Human Resources  : 63   employees, 12  left, 19.0%
-- R&D             : 961  employees, 133 left, 13.8%


-- Check 7: Gender split of employees who left
SELECT Gender, COUNT(*) AS Count
FROM dbo.HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY Gender;
-- Male 150, Female 87


-- Check 8: Which job roles have the most attrition
SELECT TOP 4
    JobRole,
    COUNT(*) AS AttritionCount
FROM dbo.HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY JobRole
ORDER BY AttritionCount DESC;
-- Lab Technician 62, Sales Executive 57, Research Scientist 47, Sales Rep 33


-- Check 9: Attrition by education field
SELECT
    EducationField,
    COUNT(*) AS Count,
    CAST(ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 0) AS INT) AS Percentage
FROM dbo.HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY EducationField
ORDER BY Count DESC;
-- Life Sciences 38%, Medical 27%, Marketing 15%, Technical Degree 14%


-- Check 10: Salary slab breakdown
SELECT SalarySlab, COUNT(*) AS AttritionCount
FROM dbo.HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY SalarySlab
ORDER BY AttritionCount DESC;
-- Upto 5k = 163, 5k-10k = 49, 10k-15k = 20, 15k+ = 5


-- Check 11: Which year had the most attrition
SELECT TOP 3 YearsAtCompany, COUNT(*) AS Count
FROM dbo.HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY YearsAtCompany
ORDER BY Count DESC;
-- Year 1 should have the highest count (59)


-- Check 12: All 8 views should exist
SELECT name AS ViewName
FROM sys.views
WHERE name LIKE 'vw_%'
ORDER BY name;