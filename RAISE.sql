drop function if exists get_season; 
create or replace function get_season (month_number int) returns text AS $$
declare
	season text;
begin 
	if month_number not between 1 and 12 then 
	raise exception 'invalid month. You passed: (%)', month_number USING HINT='Allowed from 1 up to 12', ERRCODE = 12882;
	end if;
	
	if month_number BETWEEN 3 and 5 then
		season = 'Spring';
	elsif month_number BETWEEN 6 and 8 then
		season = 'Summer';
	elsif month_number BETWEEN 9 and 11 then
		season = 'Autumn';
	else
		season = 'Winter';
	end if;
	
	return season;

end;
$$ language plpgsql;

SELECT get_season(12);

SELECT get_season(15);

DROP FUNCTION get_season_caller;
create or replace function get_season_caller(month_number int) returns text as $$
declare
	err_ctx text;
	err_msg text;
	err_details text;
	err_code text;
BEGIN
	return get_season(month_number);
EXCEPTION WHEN SQLSTATE '12882' THEN
	GET STACKED DIAGNOSTICS 
	err_ctx = PG_EXCEPTION_CONTEXT,
	err_msg = MESSAGE_TEXT,
	err_details = PG_EXCEPTION_DETAIL,
	err_code = RETURNED_SQLSTATE;
	RAISE INFO 'My custom handler:';
	RAISE INFO 'Error msg:%', err_msg;
	RAISE INFO 'Error details:%', err_details;
	RAISE INFO 'Error code:%', err_code;
	RAISE INFO 'Error context:%', err_ctx;
	RAISE INFO 'A problem. Nothing special.';
	RETURN NULL;
END;
$$ language plpgsql;

SELECT get_season_caller2(15);

create or replace function get_season_caller2(month_number int) returns text as $$
BEGIN
	return get_season(month_number);
EXCEPTION 
WHEN SQLSTATE '12882' THEN
	RAISE INFO 'My custom handler:';
	RAISE INFO 'Error Name:%', SQLERRM;
	RAISE INFO 'Error details:%', SQLSTATE;
	RETURN NULL;
WHEN OTHERS THEN
	RAISE INFO 'My custom handler OTHERS:';
	RAISE INFO 'Error Name:%', SQLERRM;
	RAISE INFO 'Error details:%', SQLSTATE;
	RETURN NULL;
END;
$$ language plpgsql;

