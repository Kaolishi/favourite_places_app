# Secure Build Script for Flutter with API Key Management (PowerShell)
# This script builds the Flutter app while securely injecting API keys

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("android", "ios")]
    [string]$Platform,
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("debug", "release")]
    [string]$BuildType = "debug"
)

# Function to print colored output
function Write-Status {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

# Check if local.properties exists
$LocalProperties = "android\local.properties"
if (-not (Test-Path $LocalProperties)) {
    Write-Error "local.properties not found at: $LocalProperties"
    Write-Error "Please create this file with your GOOGLE_MAPS_API_KEY"
    exit 1
}

# Extract API key from local.properties
$ApiKeyLine = Get-Content $LocalProperties | Where-Object { $_ -match '^GOOGLE_MAPS_API_KEY=' }
if (-not $ApiKeyLine) {
    Write-Error "GOOGLE_MAPS_API_KEY not found in $LocalProperties"
    exit 1
}

$ApiKey = ($ApiKeyLine -split '=', 2)[1].Trim()

if ([string]::IsNullOrEmpty($ApiKey)) {
    Write-Error "GOOGLE_MAPS_API_KEY is empty in $LocalProperties"
    exit 1
}

if ($ApiKey -eq "YOUR_ACTUAL_API_KEY_HERE") {
    Write-Error "Please replace the placeholder API key with your actual Google Maps API key"
    exit 1
}

Write-Status "Found API key in local.properties (length: $($ApiKey.Length))"
Write-Status "Building for: $Platform ($BuildType)"

# Build command with secure API key injection
try {
    switch ($Platform) {
        "android" {
            Write-Status "Building Android APK..."
            flutter build apk --$BuildType
        }
        "ios" {
            Write-Status "Building iOS app..."
            flutter build ios --$BuildType --dart-define=GOOGLE_MAPS_API_KEY="$ApiKey"
        }
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Status "✅ Build completed successfully!"
        Write-Warning "🔒 API key was securely injected during build"
        Write-Warning "🚫 API key is NOT stored in any committed files"
    } else {
        Write-Error "❌ Build failed with exit code: $LASTEXITCODE"
        exit $LASTEXITCODE
    }
} catch {
    Write-Error "❌ Build failed with error: $_"
    exit 1
}
