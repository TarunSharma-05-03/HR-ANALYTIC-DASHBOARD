create database HR_Analysisdb;

use HR_Analysisdb;

CREATE TABLE dbo.HR_Analytics (
    EmpID                    VARCHAR(10)  PRIMARY KEY,
    Age                      INT,
    AgeGroup                 VARCHAR(10),
    Attrition                VARCHAR(5),
    BusinessTravel           VARCHAR(30),
    DailyRate                INT,
    Department               VARCHAR(50),
    DistanceFromHome         INT,
    Education                INT,
    EducationField           VARCHAR(50),
    EmployeeCount             INT,
    EmployeeNumber           INT,
    EnvironmentSatisfaction  INT,
    Gender                   VARCHAR(10),
    HourlyRate               INT,
    JobInvolvement           INT,
    JobLevel                 INT,
    JobRole                  VARCHAR(50),
    JobSatisfaction          INT,
    MaritalStatus            VARCHAR(20),
    MonthlyIncome            INT,
    SalarySlab               VARCHAR(20),
    MonthlyRate               INT,
    NumCompaniesWorked       INT,
    Over18                   VARCHAR(5),
    OverTime                 VARCHAR(5),
    PercentSalaryHike        INT,
    PerformanceRating        INT,
    RelationshipSatisfaction INT,
    StandardHours            INT,
    StockOptionLevel         INT,
    TotalWorkingYears        INT,
    TrainingTimesLastYear    INT,
    WorkLifeBalance          INT,
    YearsAtCompany           INT,
    YearsInCurrentRole       INT,
    YearsSinceLastPromotion  INT,
    YearsWithCurrManager     INT
);

--import csv file steps
--1. Open SSMS
--2. Connect Database
--3. Right Click Database → Tasks → Import Flat File
--4. Select CSV file
--5. Validate columns & datatypes
--6. Click Finish
 -- verify import 
 select * from dbo.HR_Analytics;