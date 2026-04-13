# 🚦 SmartTraffic AI — Full Stack College Project

A **real-time traffic prediction system** using Machine Learning (RandomForest + GradientBoosting) 
with a React frontend and Flask backend.

---

## 📁 Project Structure

```
traffic-app/
├── backend/
│   ├── app.py                 ← Flask API + ML model training
│   ├── requirements.txt       ← Python dependencies
│   ├── traffic_dataset.csv    ← Auto-generated (8760 records)
│   └── traffic_model.pkl      ← Auto-trained & saved
│
├── frontend/
│   ├── src/
│   │   ├── App.jsx            ← Main app (wired to backend)
│   │   ├── App.css
│   │   ├── api/
│   │   │   └── trafficAPI.js  ← All API calls to Flask
│   │   └── components/
│   │       ├── TrafficMap.jsx          ← Leaflet dark map
│   │       ├── LocationSearch.jsx      ← City search (from API)
│   │       ├── RouteCards.jsx          ← Route comparison
│   │       ├── PredictionTimeline.jsx  ← 60-min forecast
│   │       ├── VolumeChart.jsx         ← 24h Chart.js graph
│   │       └── ModelBadge.jsx          ← ML model stats
│   └── package.json
│
├── start_backend.sh           ← One-click backend start
├── start_frontend.sh          ← One-click frontend start
└── README.md
```

---

## ⚙️ Prerequisites

| Tool | Version | Install |
|------|---------|---------|
| Python | 3.9+ | https://python.org |
| Node.js | 18+ | https://nodejs.org |
| npm | 9+ | (comes with Node) |

---

## 🚀 How to Run (Step by Step)

### Step 1 — Start the Backend

Open **Terminal 1**:

```bash
cd traffic-app
chmod +x start_backend.sh
./start_backend.sh
```

**What happens on first run:**
1. Creates Python virtual environment
2. Installs Flask, scikit-learn, pandas, numpy
3. Generates `traffic_dataset.csv` (8,760 hourly records for 1 year)
4. Trains RandomForest + GradientBoosting ensemble model
5. Saves model to `traffic_model.pkl`
6. Starts API on **http://localhost:5000**

> Subsequent runs load the saved model and start in ~2 seconds.

### Step 2 — Start the Frontend

Open **Terminal 2**:

```bash
cd traffic-app
chmod +x start_frontend.sh
./start_frontend.sh
```

This installs React packages and starts the app on **http://localhost:3000**

---

## 🔌 API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/routes` | POST | Get 3 ML-predicted routes between two points |
| `/api/prediction` | POST | Get 60-min congestion forecast for routes |
| `/api/volume` | GET | 24-hour city-wide traffic volume (for chart) |
| `/api/locations` | GET | Search city locations |
| `/api/status` | GET | Model info, accuracy metrics |

---

## 🧠 ML Model Details

### Dataset
- **8,760 records** — one per hour for a full year
- **Features:** hour, day_of_week, month, is_weekend, is_holiday, weather_code, road_type, incident flag, base_capacity
- **Targets:** congestion_pct (0–100), travel_time_multiplier
- Modelled after **Delhi NCR** traffic patterns (morning/evening peaks, monsoon, fog, holidays)

### Models
- **RandomForestRegressor** — predicts congestion percentage
- **GradientBoostingRegressor** — predicts travel time multiplier
- Both trained on 85% data, evaluated on 15% holdout
- Typical **R² ≈ 0.92+**, **MAE < 5%** congestion

### Features Explained
| Feature | Description |
|---------|-------------|
| hour | 0–23 (captures peak patterns) |
| day_of_week | 0=Mon … 6=Sun |
| month | 1–12 (seasonal patterns) |
| is_weekend | Binary flag |
| is_holiday | Delhi public holidays |
| weather_code | 0=Clear, 1=Cloudy, 2=Rain, 3=Fog, 4=Smog |
| road_type_enc | 0=Highway, 1=City, 2=Bypass |
| incident | Random road incident (5% probability per hour) |
| base_capacity | Road capacity score |

---

## 📊 What the App Shows

1. **Live Route Map** — Dark OpenStreetMap with 3 color-coded routes (Leaflet.js)
2. **Route Cards** — Congestion %, distance, travel time, AI recommendation
3. **Traffic Forecast** — 60-minute prediction at 15-min intervals
4. **24h Volume Chart** — Actual vs ML-predicted congestion (Chart.js)
5. **Model Badge** — Live R² score, MAE, dataset size

---

## 🎓 Presentation Points

- **Problem:** Urban congestion causes 1.5 hrs/day delay in Delhi NCR
- **Solution:** ML-based real-time route prediction
- **Dataset:** 8,760-record synthetic dataset based on real Delhi patterns
- **Model:** Ensemble of RandomForest + GradientBoosting
- **Accuracy:** R² ≈ 0.92 (explains 92% of congestion variance)
- **Features:** Time, weather, day type, road type, incidents, holidays
- **Real-time:** Predictions update with actual time and weather

---

## 🛠 Troubleshooting

**Backend not starting:**
```bash
pip install flask flask-cors scikit-learn pandas numpy
```

**Frontend not connecting to backend:**
- Make sure Flask is running on port 5000 before starting React
- The `"proxy": "http://localhost:5000"` in package.json routes API calls

**Model takes too long to train:**
- Normal on first run (~30 seconds)
- Subsequent runs load from `traffic_model.pkl` instantly

**Port already in use:**
```bash
# Kill process on port 5000
lsof -ti:5000 | xargs kill -9
# Kill process on port 3000
lsof -ti:3000 | xargs kill -9
```
