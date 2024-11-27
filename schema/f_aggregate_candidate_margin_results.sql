CREATE TABLE f_aggregate_candidate_margin_results (
    recording_time DateTime CODEC(DoubleDelta),

    nama_prov LowCardinality(String) CODEC(LZ4),
    nama_cab LowCardinality(String) CODEC(LZ4),
    nama_kec LowCardinality(String) CODEC(LZ4),
    nama_kel LowCardinality(String) CODEC(LZ4),
    nama_tps LowCardinality(String) CODEC(LZ4),

    location_name String,
    json_url String CODEC(ZSTD),

    leading_candidate_code LowCardinality(String),
    leading_candidate_votes UInt32,
    leading_candidate_percentage Float32,

    runner_up_candidate_code LowCardinality(String),
    runner_up_candidate_votes UInt32,
    runner_up_candidate_percentage Float32,

    margin Float32,
    total_votes UInt32
)
    ENGINE = ReplacingMergeTree(recording_time)
    ORDER BY (location_name)


INSERT INTO f_aggregate_candidate_margin_results
WITH ranked_candidates AS (
    SELECT
        recording_time,
        location_name,
        json_url,
        nama_prov,
        nama_cab,
        nama_kec,
        nama_kel,
        nama_tps,
        candidate_code,
        SUM(candidate_votes) AS votes,
        SUM(candidate_votes) / SUM(suara_total) * 100 AS percentage,
        SUM(suara_total) AS total_votes,
        ROW_NUMBER() OVER (PARTITION BY location_name ORDER BY SUM(candidate_votes) DESC) AS rank
    FROM f_raw_candidate_results
    WHERE nama_prov = 'JAWA TENGAH' AND suara_total > 0
    GROUP BY
        recording_time,
        location_name,
        json_url,
        nama_prov,
        nama_cab,
        nama_kec,
        nama_kel,
        nama_tps,
        candidate_code
)
SELECT
    recording_time,
    nama_prov,
    nama_cab,
    nama_kec,
    nama_kel,
    nama_tps,
    location_name,
    json_url,

    -- Leading candidate
    MAX(IF(rank = 1, candidate_code, NULL)) AS leading_candidate_code,
    MAX(IF(rank = 1, votes, 0)) AS leading_candidate_votes,
    MAX(IF(rank = 1, percentage, 0)) AS leading_candidate_percentage,

    -- Runner-up candidate
    MAX(IF(rank = 2, candidate_code, NULL)) AS runner_up_candidate_code,
    MAX(IF(rank = 2, votes, 0)) AS runner_up_candidate_votes,
    MAX(IF(rank = 2, percentage, 0)) AS runner_up_candidate_percentage,

    -- Margin and total votes
    MAX(IF(rank = 1, votes, 0)) - MAX(IF(rank = 2, votes, 0)) AS margin,
    MAX(total_votes) AS total_votes
FROM ranked_candidates
GROUP BY
    recording_time,
    nama_prov,
    nama_cab,
    nama_kec,
    nama_kel,
    nama_tps,
    location_name,
    json_url;
