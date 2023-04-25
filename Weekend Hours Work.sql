INSERT INTO public."WeekendHoursWorked"(
	emp_id, "timestamp")
	VALUES (1, '2023-04-25 09:00:00'),
	(1, '2023-04-25 17:00:00'),
	(1, '2023-04-22 09:00:00'),
	(1, '2023-04-22 17:00:00'),
	(1, '2023-04-23 09:00:00'),
	(1, '2023-04-23 17:00:00'),
	(2, '2023-04-21 09:00:00'),
	(2, '2023-04-21 16:30:00'),
	(2, '2023-04-23 09:00:00'),
	(2, '2023-04-23 16:30:00'),
	(3, '2023-04-23 09:00:00'),
	(3, '2023-04-23 17:00:00')
	;


with cte as (
SELECT *, extract(isodow from timestamp) as day, 
lag(timestamp) over(partition by emp_id, extract(isodow from timestamp) order by emp_id, timestamp) as clockout
FROM public."WeekendHoursWorked"
order by emp_id, timestamp
)


select emp_id,
sum(extract(hour from timestamp-clockout)) as hours_work
from cte
where day > 5 and day < 8
group by emp_id
order by emp_id


