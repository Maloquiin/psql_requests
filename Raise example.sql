drop function if exists should_increase_salary;
create or replace function should_increase_salary(
	cur_salary numeric,
	max_salary numeric DEFAULT 80, 
	min_salary numeric DEFAULT 30,
	increase_rate numeric DEFAULT 0.2
	) returns bool AS $$
declare
	new_salary numeric;
begin

	if min_salary > max_salary then 
	raise exception 'min_salary= > max_salary. Min is %, Max is %', min_salary, max_salary;
	elseif min_salary < 0 or max_salary < 0 then 
	raise exception 'min_salary or max_salary < 0. Min is %, Max is %', min_salary, max_salary;
	elseif increase_rate < 0.05 then 
	raise exception 'increase_rate = < 0.05. Rate is %', increase_rate;
	end if;

	if cur_salary >= max_salary or cur_salary >= min_salary then 		
		return false;
	end if;
	
	if cur_salary < min_salary then
		new_salary = cur_salary + (cur_salary * increase_rate);
	end if;
	
	if new_salary > max_salary then
		return false;
	else
		return true;
	end if;	
end;
$$ language plpgsql;

SELECT should_increase_salary(79,10,80,0.2);
SELECT should_increase_salary(79,10,-1,0.2);
SELECT should_increase_salary(79,10,10,0.04);