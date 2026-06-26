/* CREATE VIEWS - HR Analytics Dashboard

Total Views: 9
Power BI uses these views for dashboard visuals
 */

-- VIEW 1: Main employee view
-- Adds AttritionFlag (Yes=1, No=0)

-- VIEW 2: KPI Summary
-- Used for dashboard KPI cards
-- Shows employee count, attrition, avg age,
-- avg salary and avg years

-- VIEW 3: Attrition by Gender
-- Used in stacked bar chart

-- VIEW 4: Attrition by Education
-- Used in donut chart

-- VIEW 5: Attrition by Age Group
-- Used in column chart

-- VIEW 6: Attrition by Salary
-- Used in bar chart

-- VIEW 7: Attrition by Years at Company
-- Used in area chart

-- VIEW 8: Attrition by Job Role
-- Used in Top N bar chart

-- VIEW 9: Job Role vs Satisfaction
-- Used in matrix visual



-- VIEW 1: Employee Master View
-- Adds AttritionFlag (Yes=1, No=0)

IF OBJECT_ID('dbo.vw_HR_Employees','V') IS NOT NULL
DROP VIEW dbo.vw_HR_Employees;
GO

CREATE VIEW dbo.vw_HR_Employees AS
SELECT *,
CASE
WHEN Attrition='Yes' THEN 1
ELSE 0
END AS AttritionFlag
FROM dbo.HR_Analytics;
GO

-- VIEW 2: KPI Summary
-- Used for KPI cards

IF OBJECT_ID('dbo.vw_KPI_Summary','V') IS NOT NULL
DROP VIEW dbo.vw_KPI_Summary;
GO

CREATE VIEW dbo.vw_KPI_Summary AS
SELECT
ISNULL(Department,'All Departments') AS Department,
COUNT(*) AS CountOfEmployee,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition,
ROUND(
SUM(CASE WHEN Attrition='Yes' THEN 1.0 ELSE 0 END)
/ COUNT(*) * 100,1
) AS AttritionRatePct,
ROUND(AVG(CAST(Age AS FLOAT)),0) AS AvgAge,
ROUND(AVG(CAST(MonthlyIncome AS FLOAT))/1000,1) AS AvgSalaryK,
ROUND(AVG(CAST(YearsAtCompany AS FLOAT)),0) AS AvgYears
FROM dbo.HR_Analytics
GROUP BY GROUPING SETS((Department),());
GO


-- VIEW 3: Attrition by Gender
-- Used in stacked bar chart

IF OBJECT_ID('dbo.vw_Attrition_By_Gender','V') IS NOT NULL
DROP VIEW dbo.vw_Attrition_By_Gender;
GO

CREATE VIEW dbo.vw_Attrition_By_Gender AS
SELECT
Department,
Gender,
COUNT(*) AS AttritionCount
FROM dbo.HR_Analytics
WHERE Attrition='Yes'
GROUP BY Department, Gender;

-- VIEW 4: Attrition by Education
-- Used in donut chart

IF OBJECT_ID('dbo.vw_Attrition_By_Education','V') IS NOT NULL
DROP VIEW dbo.vw_Attrition_By_Education;
GO

CREATE VIEW dbo.vw_Attrition_By_Education AS
SELECT
Department,
EducationField,
COUNT(*) AS AttritionCount
FROM dbo.HR_Analytics
WHERE Attrition='Yes'
GROUP BY Department, EducationField;
GO


-- VIEW 5: Attrition by Age Group
-- Used in column chart

IF OBJECT_ID('dbo.vw_Attrition_By_Age','V') IS NOT NULL
DROP VIEW dbo.vw_Attrition_By_Age;
GO

CREATE VIEW dbo.vw_Attrition_By_Age AS
SELECT
Department,
AgeGroup,
COUNT(*) AS AttritionCount
FROM dbo.HR_Analytics
WHERE Attrition='Yes'
GROUP BY Department, AgeGroup;
GO


-- VIEW 6: Attrition by Salary
-- Used in bar chart

IF OBJECT_ID('dbo.vw_Attrition_By_Salary','V') IS NOT NULL
DROP VIEW dbo.vw_Attrition_By_Salary;
GO

CREATE VIEW dbo.vw_Attrition_By_Salary AS
SELECT
Department,
SalarySlab,
COUNT(*) AS AttritionCount
FROM dbo.HR_Analytics
WHERE Attrition='Yes'
GROUP BY Department, SalarySlab;
GO

-- VIEW 7: Attrition by Years at Company
-- Used in area chart

IF OBJECT_ID('dbo.vw_Attrition_By_YearsAtCompany','V') IS NOT NULL
DROP VIEW dbo.vw_Attrition_By_YearsAtCompany;
GO

CREATE VIEW dbo.vw_Attrition_By_YearsAtCompany AS
SELECT
Department,
YearsAtCompany,
COUNT(*) AS AttritionCount
FROM dbo.HR_Analytics
WHERE Attrition='Yes'
GROUP BY Department, YearsAtCompany;
GO

-- VIEW 8: Attrition by Job Role
-- Used in Top N chart

IF OBJECT_ID('dbo.vw_Attrition_By_JobRole','V') IS NOT NULL
DROP VIEW dbo.vw_Attrition_By_JobRole;
GO

CREATE VIEW dbo.vw_Attrition_By_JobRole AS
SELECT
Department,
JobRole,
COUNT(*) AS AttritionCount
FROM dbo.HR_Analytics
WHERE Attrition='Yes'
GROUP BY Department, JobRole;
GO

-- VIEW 9: Job Role vs Satisfaction
-- Used in matrix visual
IF OBJECT_ID('dbo.vw_Attrition_JobRole_Satisfaction','V') IS NOT NULL
DROP VIEW dbo.vw_Attrition_JobRole_Satisfaction;
GO

CREATE VIEW dbo.vw_Attrition_JobRole_Satisfaction AS
SELECT
Department,
JobRole,
JobSatisfaction,
COUNT(*) AS AttritionCount
FROM dbo.HR_Analytics
WHERE Attrition='Yes'
GROUP BY Department, JobRole, JobSatisfaction;
GO


-- Verify all views


SELECT name AS ViewName
FROM sys.views
WHERE name LIKE 'vw_%'
ORDER BY name;
GO
