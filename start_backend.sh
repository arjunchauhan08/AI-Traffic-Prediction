#!/bin/bash
# start_backend.sh — run this FIRST in a terminal

echo "🚦 SmartTraffic AI — Backend Setup"
echo "===================================="

cd "$(dirname "$0")/backend"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
  echo "📦 Creating Python virtual environment..."
  python3 -m venv venv
fi

source venv/bin/activate

echo "📦 Installing dependencies..."
pip install -r requirements.txt -q

echo ""
echo "🤖 Starting Flask server on http://localhost:5000"
echo "   (First run will generate dataset + train model — takes ~30s)"
echo ""
python app.py
