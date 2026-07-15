# EV Charge & Range Analysis - Visualization Tool

## Overview
An end-to-end data visualization project analyzing electric vehicle charging behavior and range performance across 25 EV models, built as part of a Tableau data analytics internship/project. The project covers the full pipeline: data collection, database design, SQL analysis, Tableau visualization, dashboard/story building, and web integration via Flask.

## Demo
- **Tableau Public Dashboard:** _[https://public.tableau.com/app/profile/t.gowtham.reddy/viz/EVChargeAnalysisRangeAnalysis/EVAnalysisStory]_
- **Live Web App:** _[tested locally]_

## Tech Stack
- **Data:** Python (dataset generation), CSV
- **Database:** MySQL
- **Analysis:** SQL (joins, aggregates, subqueries, conditional logic)
- **Visualization:** Tableau
- **Web Integration:** Flask, HTML

## Project Structure
```
ev-charge-range-analysis/
├── data/
│   ├── vehicles.csv               # 25 EV models with specs
│   └── charging_sessions.csv      # 60 charging session records
├── sql/
│   └── schema_and_queries.sql     # DB schema + analysis queries
├── flask_app/
│   ├── app.py                     # Flask app serving the dashboard
│   └── templates/
│       └── index.html             # Embedded Tableau viz page
├── docs/
│   └── project_documentation.pdf  # Full write-up (see Epic structure below)
└── README.md
```

## Dataset Description
**vehicles.csv** (25 records) — make, model, year, vehicle type, battery capacity (kWh), rated range (km), efficiency (Wh/km), price (INR)

**charging_sessions.csv** (60 records) — linked to vehicles via `vehicle_id`; charger type, charging power, start/end charge %, charge time, temperature, city, session date

## Key Insights
- Which charger type offers the fastest average charging time
- Correlation between battery capacity and real-world range
- Impact of ambient temperature on charging speed
- Most range-efficient vehicles (km per kWh)

## Project Epics
1. Data Collection & Extraction from Database
2. Data Preparation
3. Data Visualization
4. Dashboard
5. Story
6. Performance Testing
7. Web Integration
8. Project Demonstration & Documentation

## How to Run Locally
1. Set up MySQL and run `sql/schema_and_queries.sql` to create tables
2. Import `data/vehicles.csv` and `data/charging_sessions.csv` into the respective tables
3. Open Tableau Desktop → connect to the `ev_analysis` MySQL database
4. Build/open the visualizations and dashboard
5. To run the Flask wrapper:
   ```bash
   cd flask_app
   pip install flask
   python app.py
   ```
6. Open `http://localhost:5000` in your browser

## Author
Gowtham Reddy T.
