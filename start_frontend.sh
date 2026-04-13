#!/bin/bash
# start_frontend.sh — run this in a SECOND terminal after backend is running

echo "🖥  SmartTraffic AI — Frontend Setup"
echo "====================================="

cd "$(dirname "$0")/frontend"

if [ ! -d "node_modules" ]; then
  echo "📦 Installing Node packages (takes 1-2 min first time)..."
  npm install
fi

echo ""
echo "🚀 Starting React app on http://localhost:3000"
echo ""
npm start
