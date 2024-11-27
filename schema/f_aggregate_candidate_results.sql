CREATE TABLE f_aggregate_candidate_results (
   nama_prov LowCardinality(String) CODEC(LZ4),
   nama_cab LowCardinality(String) CODEC(LZ4),
   nama_kec LowCardinality(String) CODEC(LZ4),
   nama_kel LowCardinality(String) CODEC(LZ4),

   candidate_code LowCardinality(String) CODEC(LZ4),
   total_votes UInt64,

   INDEX idx_nama_prov (nama_prov) TYPE bloom_filter(0.01) GRANULARITY 1,
   INDEX idx_nama_cab (nama_cab) TYPE bloom_filter(0.01) GRANULARITY 1,
   INDEX idx_nama_kec (nama_kec) TYPE bloom_filter(0.01) GRANULARITY 1,
   INDEX idx_nama_kel (nama_kel) TYPE bloom_filter(0.01) GRANULARITY 1,
   INDEX idx_candidate_code (candidate_code) TYPE bloom_filter(0.01) GRANULARITY 1
)
    ENGINE = SummingMergeTree()
    PARTITION BY (nama_prov, nama_cab)
    ORDER BY (candidate_code, nama_prov, nama_cab, nama_kec, nama_kel)
    SETTINGS index_granularity = 8192;

CREATE MATERIALIZED VIEW mv_aggregate_candidate_results
TO f_aggregate_candidate_results
AS
SELECT
    nama_prov,
    nama_cab,
    nama_kec,
    nama_kel,
    candidate_code,
    SUM(candidate_votes) AS total_votes
FROM f_raw_candidate_results
GROUP BY
    nama_prov,
    nama_cab,
    nama_kec,
    nama_kel,
    candidate_code;