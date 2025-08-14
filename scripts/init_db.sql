-- Enable PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;

-- Basic spatial tables (can be extended)
CREATE TABLE IF NOT EXISTS spatial_references (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    admin_level TEXT,
    geom geometry(GEOMETRY, 4326) NOT NULL,
    metadata JSONB
);

CREATE INDEX IF NOT EXISTS spatial_references_gix ON spatial_references USING GIST (geom);

-- Time series example (TimescaleDB optional)
CREATE TABLE IF NOT EXISTS energy_timeseries (
    id BIGSERIAL PRIMARY KEY,
    ts TIMESTAMPTZ NOT NULL,
    metric TEXT NOT NULL,
    value DOUBLE PRECISION NOT NULL,
    unit TEXT NOT NULL,
    spatial_ref_id INT REFERENCES spatial_references(id) ON DELETE SET NULL,
    source TEXT
);
CREATE INDEX IF NOT EXISTS energy_timeseries_ts_idx ON energy_timeseries (ts);