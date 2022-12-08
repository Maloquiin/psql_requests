EXPLAIN ANALYZE
SELECT *
FROM perf_test
WHERE reason LIKE '%dfe%';

CREATE EXTENSION pg_trgm;

CREATE INDEX trgm_idx_perf_test_reason ON perf_test USING gin (reason gin_trgm_ops);