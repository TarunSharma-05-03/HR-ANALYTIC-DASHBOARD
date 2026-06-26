--remove Duplicate rows

--solution : DELETE DUPLICATE ROWS USING CTE + ROW_NUMBER() 

--step 1 : Check how many duplicate rows there are
select EmpID, COUNT(*) AS DUPLICATE from HR_Analytics 
group by EmpID
having count(*)>1;

--STEP 2 DELETE DUPLICATE ROW
-- row_number() Assign a unique row number to each row 
with Rankedrow as
(SELECT *, ROW_NUMBER() over (partition by EmpID order by (select  null) ) as rn  
from dbo.HR_Analytics t )
delete from Rankedrow
where rn>1; -- Duplicate EmpID records are deleted and only one row per employee remains.

-- Confirmed that there are no duplicate values left
select count(*) as totalrows from dbo.hr_Analytics;