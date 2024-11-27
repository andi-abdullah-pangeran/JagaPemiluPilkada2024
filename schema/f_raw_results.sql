CREATE TABLE f_raw_results (
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

    hasil_candidates Map(String, Nullable(UInt32)),

    result JSON,
    tingkat UInt8 CODEC(T64),

    verify_hasil bool,
    verify_hasil_candidates bool,
    verify_control bool,

    INDEX idx_nama_prov (nama_prov) TYPE bloom_filter(0.01) GRANULARITY 1,
    INDEX idx_nama_cab (nama_cab) TYPE bloom_filter(0.01) GRANULARITY 1,
    INDEX idx_nama_kec (nama_kec) TYPE bloom_filter(0.01) GRANULARITY 1,
    INDEX idx_nama_kel (nama_kel) TYPE bloom_filter(0.01) GRANULARITY 1
)
    ENGINE = MergeTree()
    PARTITION BY (location_partition)
    ORDER BY (location_name, recording_time)
    SETTINGS index_granularity = 8192;