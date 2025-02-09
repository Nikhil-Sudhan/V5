from fastapi import FastAPI
import sqlite3
from pydantic import BaseModel

app = FastAPI()

# Data model for request validation
class MissionRequest(BaseModel):
    mission_type: str
    vehicle: str
    prompt: str

# Function to fetch drone data from SQLite
def fetch_drone_data():
    conn = sqlite3.connect("F:/V5/version5/lib/database/drone_data.db")
    cursor = conn.cursor()
    
    cursor.execute("SELECT * FROM drones")
    data = cursor.fetchall()
    conn.close()

    # Convert to JSON format
    drones = []
    for row in data:
        drones.append({
            "name": row[1],
            "id": row[0],
            "status": row[2],
            "type": row[3],
            "connectivity": row[4],
            "battery_percentage": row[5],
            "signal_strength": row[6],
            "latitude": row[7],
            "longitude": row[8],
            "speed": row[9],
            "altitude": row[10]
        })
    
    return drones

# API Endpoint to get drone data
@app.get("/drones")
def get_drones():
    return fetch_drone_data()

@app.post("/assign_task")
async def assign_task(request: MissionRequest):
    print(f"Mission Type: {request.mission_type}")
    print(f"Vehicle: {request.vehicle}")
    print(f"Prompt: {request.prompt}")
    return {"message": "Task received successfully"}

# Run server
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
