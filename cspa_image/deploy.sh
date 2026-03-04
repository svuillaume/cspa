#!/bin/bash

# Security Assessment Docker Deployment Script
# This script helps deploy the security assessment application

set -e

echo "🔴⚫ Hybrid and Multi-Cloud Security Assessment - Docker Deployment"
echo "================================================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    echo "   Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

echo "✅ Docker is installed"

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "❌ Docker is not running. Please start Docker."
    exit 1
fi

echo "✅ Docker is running"
echo ""

# Menu
echo "Select deployment method:"
echo "  1) Docker Compose (Recommended)"
echo "  2) Docker CLI"
echo "  3) Stop and remove containers"
echo "  4) View logs"
echo "  5) Exit"
echo ""
read -p "Enter choice [1-5]: " choice

case $choice in
    1)
        echo ""
        echo "🚀 Starting with Docker Compose..."
        docker-compose up -d
        echo ""
        echo "✅ Application is running!"
        echo "🌐 Access at: http://localhost:8080"
        ;;
    2)
        echo ""
        echo "🚀 Building and starting with Docker CLI..."
        docker build -t security-assessment .
        docker run -d -p 8080:80 --name security-assessment-app security-assessment
        echo ""
        echo "✅ Application is running!"
        echo "🌐 Access at: http://localhost:8080"
        ;;
    3)
        echo ""
        echo "🛑 Stopping containers..."
        docker-compose down 2>/dev/null || docker stop security-assessment-app 2>/dev/null || true
        docker rm security-assessment-app 2>/dev/null || true
        echo "✅ Containers stopped and removed"
        ;;
    4)
        echo ""
        echo "📋 Viewing logs (Ctrl+C to exit)..."
        docker logs -f security-assessment-app
        ;;
    5)
        echo "Goodbye! 👋"
        exit 0
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "================================================================="
echo "Deployment complete! 🎉"
