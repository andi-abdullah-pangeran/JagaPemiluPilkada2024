CREATE TABLE f_raw_candidate_results (
    recording_time DateTime CODEC(DoubleDelta),

    location_id String CODEC(ZSTD),
    location_partition String CODEC(ZSTD),
    location_name LowCardinality(String) CODEC(LZ4),
    json_url String CODEC(ZSTD),

    nama_prov LowCardinality(String) CODEC(LZ4),
    nama_cab LowCardinality(String) CODEC(LZ4),
    nama_kec LowCardinality(String) CODEC(LZ4),
    nama_kel LowCardinality(String) CODEC(LZ4),
    nama_tps LowCardinality(String) CODEC(LZ4),

    suara_sah UInt32,
    suara_tidak_sah UInt32,
    suara_total UInt32,

    candidate_code LowCardinality(String) CODEC(LZ4),
    candidate_votes Nullable(UInt32),

    INDEX idx_nama_prov (nama_prov) TYPE bloom_filter(0.01) GRANULARITY 1,
    INDEX idx_nama_cab (nama_cab) TYPE bloom_filter(0.01) GRANULARITY 1,
    INDEX idx_nama_kec (nama_kec) TYPE bloom_filter(0.01) GRANULARITY 1,
    INDEX idx_nama_kel (nama_kel) TYPE bloom_filter(0.01) GRANULARITY 1
)
    ENGINE = ReplacingMergeTree(recording_time)
    PARTITION BY (location_partition)
    ORDER BY (candidate_code, location_id)
    SETTINGS index_granularity = 8192;

CREATE MATERIALIZED VIEW mv_f_raw_candidate_results
TO f_raw_candidate_results
AS
SELECT
    recording_time,
    location_id,
    location_partition,
    location_name,
    json_url,
    nama_prov,
    nama_cab,
    nama_kec,
    nama_kel,
    nama_tps,
    suara_sah,
    suara_tidak_sah,
    suara_total,
    candidate_code,
    candidate_votes
FROM f_raw_results
         ARRAY JOIN
     mapKeys(hasil_candidates) AS candidate_code,
     mapValues(hasil_candidates) AS candidate_votes
WHERE hasil_candidates IS NOT NULL;