-- Insert test users
INSERT INTO users (email, password, first_name, last_name, role, department, phone, is_active)
VALUES 
    ('admin@gis.com', '$2a$10$YourHashedPasswordHere', 'Admin', 'User', 'admin', 'Management', '+84-XXX-XXXX', true),
    ('manager@gis.com', '$2a$10$YourHashedPasswordHere', 'Manager', 'User', 'manager', 'Operations', '+84-XXX-XXXX', true),
    ('viewer@gis.com', '$2a$10$YourHashedPasswordHere', 'Viewer', 'User', 'viewer', 'Support', '+84-XXX-XXXX', true)
ON CONFLICT (email) DO NOTHING;

-- Electricity Lines
INSERT INTO electricity_lines (name, line_type, voltage_level, capacity, length, construction_year, status, owner, geom, created_by)
VALUES
    ('Đường dây 110kV Hà Nội - Hải Phòng', 'overhead', 110, 500, 120, 2015, 'operational', 'EVN', 
     ST_GeomFromText('LINESTRING(105.8 21.0, 106.5 20.8)', 4326), 1),
    ('Đường dây 220kV Hà Nội - Hưng Yên', 'overhead', 220, 800, 80, 2018, 'operational', 'EVN',
     ST_GeomFromText('LINESTRING(105.8 21.0, 106.2 21.3)', 4326), 1),
    ('Đường dây 10kV Phố cổ Hà Nội', 'underground', 10, 50, 5, 2020, 'operational', 'PC Hà Nội',
     ST_GeomFromText('LINESTRING(105.85 21.03, 105.87 21.02)', 4326), 1);

-- Electricity Substations
INSERT INTO electricity_substations (name, substation_type, voltage_primary, voltage_secondary, transformer_count, transformer_capacity, installation_year, status, owner, contact_person, phone, geom, created_by)
VALUES
    ('Trạm biến áp 110/10kV Hoàn Kiếm', 'distribution', 110, 10, 3, 90, 2010, 'operational', 'PC Hà Nội', 'Trần A', '+84-XXX-XXXX',
     ST_GeomFromText('POINT(105.85 21.03)', 4326), 1),
    ('Trạm biến áp 220/110kV Thanh Xuân', 'transmission', 220, 110, 2, 200, 2015, 'operational', 'EVN', 'Nguyễn B', '+84-XXX-XXXX',
     ST_GeomFromText('POINT(105.78 20.98)', 4326), 1),
    ('Trạm biến áp 10/0.4kV Cầu Giấy', 'distribution', 10, 0.4, 1, 10, 2018, 'operational', 'PC Hà Nội', 'Hoàng C', '+84-XXX-XXXX',
     ST_GeomFromText('POINT(105.78 21.05)', 4326), 1);

-- Water Pipes
INSERT INTO water_pipes (pipe_id, diameter, material, length, installation_year, last_maintenance_year, pressure_level, status, pipe_type, owner, geom, created_by)
VALUES
    ('NW-001-HN', 300, 'PVC', 2.5, 2010, 2022, 6, 'operational', 'main', 'HAWACO', 
     ST_GeomFromText('LINESTRING(105.80 21.00, 105.82 21.02)', 4326), 1),
    ('NW-002-HN', 200, 'cast_iron', 3.0, 2005, 2023, 5, 'operational', 'secondary', 'HAWACO',
     ST_GeomFromText('LINESTRING(105.82 21.02, 105.85 21.03)', 4326), 1),
    ('NW-003-HN', 100, 'PVC', 1.5, 2015, 2023, 4, 'operational', 'tertiary', 'HAWACO',
     ST_GeomFromText('LINESTRING(105.85 21.03, 105.87 21.04)', 4326), 1);

-- Roads
INSERT INTO roads (name, road_type, lanes, width, surface, speed_limit, length, construction_year, last_maintenance_year, condition, status, geom, created_by)
VALUES
    ('Đường Lê Lợi', 'primary', 4, 35, 'asphalt', 50, 1.5, 2000, 2023, 'good', 'operational',
     ST_GeomFromText('LINESTRING(105.84 21.02, 105.86 21.04)', 4326), 1),
    ('Phố Cổ Hà Nội', 'residential', 2, 8, 'asphalt', 30, 0.8, 1990, 2021, 'fair', 'operational',
     ST_GeomFromText('LINESTRING(105.85 21.03, 105.87 21.04)', 4326), 1),
    ('Đường Ngô Sĩ Liên', 'secondary', 3, 20, 'concrete', 40, 2.2, 2010, 2022, 'good', 'operational',
     ST_GeomFromText('LINESTRING(105.80 21.00, 105.85 21.05)', 4326), 1);

-- Traffic Signals
INSERT INTO traffic_signals (signal_id, intersection_name, signal_type, installation_year, last_maintenance_year, condition, status, is_synchronized, geom, created_by)
VALUES
    ('TS-001-HK', 'Giao lộ Lê Lợi - Đinh Tiên Hoàng', 'traffic_light', 2015, 2023, 'good', 'operational', true,
     ST_GeomFromText('POINT(105.85 21.03)', 4326), 1),
    ('TS-002-HK', 'Giao lộ Bà Triệu - Tây Sơn', 'traffic_light', 2012, 2022, 'fair', 'operational', true,
     ST_GeomFromText('POINT(105.86 21.02)', 4326), 1);

-- Parking Facilities
INSERT INTO parking_facilities (name, parking_type, total_spaces, available_spaces, hourly_rate, daily_rate, opening_hours, is_24h, status, operator, geom, created_by)
VALUES
    ('Bãi đỗ xe Hoàn Kiếm Center', 'multi_level', 500, 150, 30000, 150000, '06:00-23:00', false, 'operational', 'HC Center',
     ST_GeomFromText('POINT(105.85 21.02)', 4326), 1),
    ('Bãi đỗ xe Hàng Bông', 'surface', 200, 50, 20000, 100000, '24/24', true, 'operational', 'Quản lý quận 1',
     ST_GeomFromText('POINT(105.86 21.03)', 4326), 1);

-- Transit Stops
INSERT INTO transit_stops (stop_id, name, stop_type, routes_served, shelter, bench_count, trash_bins, accessibility, status, geom, created_by)
VALUES
    ('TS-B01', 'Trạm Hoàn Kiếm', 'bus', '01,02,03,24,25', true, 4, 2, true, 'operational',
     ST_GeomFromText('POINT(105.85 21.03)', 4326), 1),
    ('TS-B02', 'Trạm Bà Triệu', 'bus', '04,05,06', true, 3, 1, true, 'operational',
     ST_GeomFromText('POINT(105.85 21.02)', 4326), 1);

-- Incidents
INSERT INTO incidents (incident_type, infrastructure_type, location, description, severity, status, reported_by, assigned_to, estimated_duration, affected_population, geom, created_at)
VALUES
    ('outage', 'electricity_lines', 'Phố Cổ Hà Nội', 'Cắt điện do bảo trì', 'medium', 'open', 1, 2, 120, 5000,
     ST_GeomFromText('POINT(105.85 21.03)', 4326), CURRENT_TIMESTAMP - INTERVAL '2 days'),
    ('leak', 'water_pipes', 'Đường Lê Lợi', 'Rò rỉ nước trên đường chính', 'high', 'open', 1, 2, 240, 10000,
     ST_GeomFromText('POINT(105.85 21.02)', 4326), CURRENT_TIMESTAMP - INTERVAL '1 day');
