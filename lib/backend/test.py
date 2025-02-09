import sqlite3

# Connect to SQLite database (or create it if it doesn't exist)
conn = sqlite3.connect("F:/V5/version5/lib/database/drone_data.db")
cursor = conn.cursor()

# Create table for drone vehicle data
cursor.execute('''
CREATE TABLE IF NOT EXISTS drones (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    status TEXT CHECK(status IN ('online', 'offline', 'standby')) NOT NULL,
    type TEXT CHECK(type IN ('quad', 'vtol')) NOT NULL,
    connectivity TEXT CHECK(connectivity IN ('connected', 'not connected')) NOT NULL,
    battery_percentage INTEGER,
    signal_strength INTEGER,
    latitude REAL,
    longitude REAL,
    speed REAL,
    altitude REAL
)
''')

# Insert sample data
sample_data = [
    ("Atlas","online", "quad", "connected", 85, 78, 12.9716, 77.5946, 45.2, 120.5),
    ("Voyager","standby", "vtol", "connected", 90, 82, 13.0827, 80.2707, 0.0, 50.0),
    ("Specter","offline", "quad", "not connected", None, None, None, None, None, None),
    ("Atlas","online", "vtol", "connected", 70, 65, 28.6139, 77.2090, 60.8, 200.0),
    ("Atlas","standby", "quad", "not connected", None, None, None, None, None, None)
]

# Insert data into table
cursor.executemany('''
INSERT INTO drones (name,status, type, connectivity, battery_percentage, signal_strength, latitude, longitude, speed, altitude)
VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?)
''', sample_data)

# Commit changes and close connection
conn.commit()
conn.close()

print("Drone vehicle database created successfully with sample data.")
