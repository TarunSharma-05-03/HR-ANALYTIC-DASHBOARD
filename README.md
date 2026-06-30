# HR-ANALYTIC-DASHBOARD
HR-Analytics Dashboard using SQL Server and Power BI


I build this project to practice SQl amd Power BI together.

**what i Did**


i took an HR dataset with 1470 employees record and tried to find out why people leave the company.
Firstly I loaded the data into SQL Server.then i wrote the query to clean and organize it.
After that i connected powwer BI and build a DAshboard with charts and filters.

**TOOLS USED**

SQL Server Express
SSMS
Power BI


**DATASET**

HR Analytics dataset from kaggle. 1470 rows and 38 columns - age,salary,job role, department, years at company, job satisfication and more.


**Files in This Repo**

File                                        What it does
create table.sql                         Table structure with all column names and data types
Remove_duplicates.sql                    Removes 10 duplicate rows that came in after import
views.sql                                8 SQL views that Power BI connects to
validation.sql                           Queries I ran to verify all numbers before building the dashboard


**Dashboard Numbers**


            All Departments       Sales          HR                 R&D
Employees     1470                446            63                 961
Attrition     237                 92             12                 133
Rate          16.1%               20.6%          19.0%              13.8%



**Key Findings**



Sales department has the highest attrition at 20.6%

163 out of 237 employees who left were earning below 5K per month

Age group 26 to 35 had the most attrition with 116 employees

Year 1 is the most critical — 59 employees left in their first year

Laboratory Technician role had the highest attrition with 62 employees

**Problems I Ran Into**



**Wrong data after first import**

Two things went wrong the first time I imported the CSV.

The Attrition column stored 1 and 0 instead of Yes and No. The import wizard auto-detected it as boolean type. I went into the Modify Columns screen and manually changed it to text type (nvarchar).

Also 1480 rows came in instead of 1470 because there was no primary key set. Duplicate records got inserted. I fixed this by writing a CTE query with ROW_NUMBER to find and delete the extra rows.

**DAX measure returning wrong value**


My Attrition Count measure was returning 1470 instead of 237 after connecting Power BI. I found that the Attrition column values had trailing spaces so the filter was not matching. Adding TRIM() in the DAX formula fixed it.


**SQL Concepts Used**


CREATE TABLE with explicit data types
CTE (Common Table Expression)
ROW_NUMBER() with PARTITION BY
GROUPING SETS
CASE WHEN
Views
Aggregate functions (COUNT, SUM, AVG, ROUND)
ISNULL


**DAX Measures**


Total Employees = COUNTROWS(vw_HR_Employees)

Attrition Count = CALCULATE([Total Employees], TRIM(vw_HR_Employees[Attrition]) = "Yes")

Attrition Rate = DIVIDE([Attrition Count], [Total Employees])

Avg Age = AVERAGE(vw_HR_Employees[Age])

Avg Salary K = DIVIDE(AVERAGE(vw_HR_Employees[MonthlyIncome]), 1000)

Avg Years = AVERAGE(vw_HR_Employees[YearsAtCompany])
