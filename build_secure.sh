#!/bin/bash

# Secure Build Script for Flutter with API Key Management
# This script builds the Flutter app while securely injecting API keys

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if local.properties exists
LOCAL_PROPERTIES="android/local.properties"
if [ ! -f "$LOCAL_PROPERTIES" ]; then
    print_error "local.properties not found at: $LOCAL_PROPERTIES"
    print_error "Please create this file with your GOOGLE_MAPS_API_KEY"
    exit 1
fi

# Extract API key from local.properties
API_KEY=$(grep '^GOOGLE_MAPS_API_KEY=' "$LOCAL_PROPERTIES" | cut -d'=' -f2 | tr -d '\r\n')

if [ -z "$API_KEY" ]; then
    print_error "GOOGLE_MAPS_API_KEY not found in $LOCAL_PROPERTIES"
    exit 1
fi

if [ "$API_KEY" = "YOUR_ACTUAL_API_KEY_HERE" ]; then
    print_error "Please replace the placeholder API key with your actual Google Maps API key"
    exit 1
fi

print_status "Found API key in local.properties (length: ${#API_KEY})"

# Parse command line arguments
PLATFORM=""
BUILD_TYPE="debug"

while [[ $# -gt 0 ]]; do
    case $1 in
        android|ios)
            PLATFORM="$1"
            shift
            ;;
        debug|release)
            BUILD_TYPE="$1"
            shift
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Usage: $0 [android|ios] [debug|release]"
            exit 1
            ;;
    esac
done

if [ -z "$PLATFORM" ]; then
    print_error "Please specify platform: android or ios"
    echo "Usage: $0 [android|ios] [debug|release]"
    exit 1
fi

print_status "Building for: $PLATFORM ($BUILD_TYPE)"

# Build command with secure API key injection
case "$PLATFORM" in
    android)
        print_status "Building Android APK..."
        flutter build apk --$BUILD_TYPE
        ;;
    ios)
        print_status "Building iOS app..."
        flutter build ios --$BUILD_TYPE --dart-define=GOOGLE_MAPS_API_KEY="$API_KEY"
        ;;
esac

if [ $? -eq 0 ]; then
    print_status "✅ Build completed successfully!"
    print_warning "🔒 API key was securely injected during build"
    print_warning "🚫 API key is NOT stored in any committed files"
else
    print_error "❌ Build failed"
    exit 1
fi
