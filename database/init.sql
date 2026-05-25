-- ============================================================
-- Urban Infrastructure GIS Database Initialization
-- ============================================================

-- Enable PostGIS extension
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;
CREATE EXTENSION IF NOT EXISTS uuid-ossp;

-- ============================================================
-- USERS & ROLES TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    role VARCHAR(50) DEFAULT 'user',
    department VARCHAR(100),
    phone VARCHAR(20),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_uuid ON users(uuid);

-- ============================================================
-- ELECTRICITY INFRASTRUCTURE
-- ============================================================

CREATE TABLE IF NOT EXISTS electricity_lines (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    name VARCHAR(255) NOT NULL,
    line_type VARCHAR(50),
    voltage_level INT,
    capacity FLOAT,
    length FLOAT,
    construction_year INT,
    status VARCHAR(50) DEFAULT 'operational',
    owner VARCHAR(100),
    geom GEOMETRY(LINESTRING, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES users(id),
    updated_by INT REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS electricity_substations (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    name VARCHAR(255) NOT NULL,
    substation_type VARCHAR(100),
    voltage_primary INT,
    voltage_secondary INT,
    transformer_count INT,
    transformer_capacity FLOAT,
    installation_year INT,
    status VARCHAR(50) DEFAULT 'operational',
    owner VARCHAR(100),
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    geom GEOMETRY(POINT, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES users(id),
    updated_by INT REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS electricity_poles (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    pole_id VARCHAR(100) UNIQUE,
    pole_type VARCHAR(50),
    height FLOAT,
    condition VARCHAR(50),
    installation_year INT,
    maintenance_year INT,
    status VARCHAR(50) DEFAULT 'operational',
    geom GEOMETRY(POINT, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES users(id),
    updated_by INT REFERENCES users(id)
);

-- ============================================================
-- WATER INFRASTRUCTURE
-- ============================================================

CREATE TABLE IF NOT EXISTS water_pipes (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    pipe_id VARCHAR(100) UNIQUE,
    diameter INT,
    material VARCHAR(50),
    length FLOAT,
    installation_year INT,
    last_maintenance_year INT,
    pressure_level INT,
    status VARCHAR(50) DEFAULT 'operational',
    pipe_type VARCHAR(50),
    owner VARCHAR(100),
    geom GEOMETRY(LINESTRING, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES users(id),
    updated_by INT REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS water_facilities (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    name VARCHAR(255) NOT NULL,
    facility_type VARCHAR(50),
    capacity FLOAT,
    treatment_method VARCHAR(100),
    daily_production FLOAT,
    water_source VARCHAR(100),
    installation_year INT,
    status VARCHAR(50) DEFAULT 'operational',
    operator VARCHAR(100),
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    geom GEOMETRY(POINT, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES users(id),
    updated_by INT REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS water_meters (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    meter_id VARCHAR(100) UNIQUE,
    meter_type VARCHAR(50),
    consumer_name VARCHAR(255),
    consumer_phone VARCHAR(20),
    address VARCHAR(255),
    installation_year INT,
    last_reading FLOAT,
    last_reading_date DATE,
    status VARCHAR(50) DEFAULT 'active',
    geom GEOMETRY(POINT, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES users(id),
    updated_by INT REFERENCES users(id)
);

-- ============================================================
-- TRANSPORTATION INFRASTRUCTURE
-- ============================================================

CREATE TABLE IF NOT EXISTS roads (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    name VARCHAR(255) NOT NULL,
    road_type VARCHAR(50),
    lanes INT,
    width FLOAT,
    surface VARCHAR(50),
    speed_limit INT,
    length FLOAT,
    construction_year INT,
    last_maintenance_year INT,
    condition VARCHAR(50),
    status VARCHAR(50) DEFAULT 'operational',
    geom GEOMETRY(LINESTRING, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES users(id),
    updated_by INT REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS traffic_signals (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    signal_id VARCHAR(100) UNIQUE,
    intersection_name VARCHAR(255),
    signal_type VARCHAR(50),
    installation_year INT,
    last_maintenance_year INT,
    condition VARCHAR(50),
    status VARCHAR(50) DEFAULT 'operational',
    is_synchronized BOOLEAN DEFAULT false,
    geom GEOMETRY(POINT, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES users(id),
    updated_by INT REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS parking_facilities (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    name VARCHAR(255) NOT NULL,
    parking_type VARCHAR(50),
    total_spaces INT,
    available_spaces INT,
    hourly_rate FLOAT,
    daily_rate FLOAT,
    opening_hours VARCHAR(100),
    is_24h BOOLEAN DEFAULT false,
    status VARCHAR(50) DEFAULT 'operational',
    operator VARCHAR(100),
    geom GEOMETRY(POINT, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES users(id),
    updated_by INT REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS transit_stops (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    stop_id VARCHAR(100) UNIQUE,
    name VARCHAR(255) NOT NULL,
    stop_type VARCHAR(50),
    routes_served TEXT,
    shelter BOOLEAN DEFAULT false,
    bench_count INT,
    trash_bins INT,
    accessibility BOOLEAN DEFAULT false,
    status VARCHAR(50) DEFAULT 'operational',
    geom GEOMETRY(POINT, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES users(id),
    updated_by INT REFERENCES users(id)
);

-- ============================================================
-- MAINTENANCE & INSPECTION LOGS
-- ============================================================

CREATE TABLE IF NOT EXISTS maintenance_logs (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    infrastructure_type VARCHAR(50),
    infrastructure_id INT,
    maintenance_date DATE,
    maintenance_type VARCHAR(100),
    description TEXT,
    cost FLOAT,
    duration INT,
    contractor VARCHAR(100),
    assigned_to INT REFERENCES users(id),
    completed_by INT REFERENCES users(id),
    status VARCHAR(50) DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_maintenance_logs_infrastructure ON maintenance_logs(infrastructure_type, infrastructure_id);
CREATE INDEX idx_maintenance_logs_date ON maintenance_logs(maintenance_date);

-- ============================================================
-- INCIDENTS & ALERTS
-- ============================================================

CREATE TABLE IF NOT EXISTS incidents (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE,
    incident_type VARCHAR(50),
    infrastructure_type VARCHAR(50),
    location TEXT,
    description TEXT,
    severity VARCHAR(50),
    status VARCHAR(50) DEFAULT 'open',
    reported_by INT REFERENCES users(id),
    assigned_to INT REFERENCES users(id),
    estimated_duration INT,
    actual_duration INT,
    affected_population INT,
    image_url VARCHAR(500),
    geom GEOMETRY(POINT, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_incidents_status ON incidents(status);
CREATE INDEX idx_incidents_severity ON incidents(severity);
CREATE INDEX idx_incidents_created_at ON incidents(created_at);

-- ============================================================
-- AUDIT LOG
-- ============================================================

CREATE TABLE IF NOT EXISTS audit_logs (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    action VARCHAR(100),
    entity_type VARCHAR(50),
    entity_id INT,
    old_value JSONB,
    new_value JSONB,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_created_at ON audit_logs(created_at);
CREATE INDEX idx_audit_logs_entity ON audit_logs(entity_type, entity_id);

-- ============================================================
-- CREATE SPATIAL INDEXES
-- ============================================================

CREATE INDEX idx_electricity_lines_geom ON electricity_lines USING GIST(geom);
CREATE INDEX idx_electricity_substations_geom ON electricity_substations USING GIST(geom);
CREATE INDEX idx_electricity_poles_geom ON electricity_poles USING GIST(geom);
CREATE INDEX idx_water_pipes_geom ON water_pipes USING GIST(geom);
CREATE INDEX idx_water_facilities_geom ON water_facilities USING GIST(geom);
CREATE INDEX idx_water_meters_geom ON water_meters USING GIST(geom);
CREATE INDEX idx_roads_geom ON roads USING GIST(geom);
CREATE INDEX idx_traffic_signals_geom ON traffic_signals USING GIST(geom);
CREATE INDEX idx_parking_facilities_geom ON parking_facilities USING GIST(geom);
CREATE INDEX idx_transit_stops_geom ON transit_stops USING GIST(geom);
CREATE INDEX idx_incidents_geom ON incidents USING GIST(geom);

-- ============================================================
-- GRANT PERMISSIONS
-- ============================================================

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO gis_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO gis_user;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO gis_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO gis_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO gis_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON FUNCTIONS TO gis_user;
