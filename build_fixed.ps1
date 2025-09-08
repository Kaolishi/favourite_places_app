# Flutter Build Script with Permanent Java Fix
# This script ensures Java environment is always correct

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("debug", "release")]
    [string]$BuildType = "debug"
)

# Set correct Java path for this session
$env:JAVA_HOME = "C:\Program Files\Java\jdk-23"

Write-Host "Using Java: $env:JAVA_HOME" -ForegroundColor Green

# Verify Java is accessible
try {
    $javaVersion = & "$env:JAVA_HOME\bin\java.exe" -version 2>&1
    Write-Host "Java Version: $($javaVersion[0])" -ForegroundColor Green
} catch {
    Write-Host "Error: Java not found at $env:JAVA_HOME" -ForegroundColor Red
    exit 1
}

# Build the app
Write-Host "Building Flutter APK ($BuildType)..." -ForegroundColor Yellow

# Run the build
flutter build apk --$BuildType

# Check if APK was generated (even if Flutter reports failure)
$apkPath = "android\app\build\outputs\apk\$BuildType\app-$BuildType.apk"
$flutterApkDir = "build\app\outputs\flutter-apk"
$flutterApkPath = "$flutterApkDir\app-$BuildType.apk"

if (Test-Path $apkPath) {
    Write-Host "APK generated successfully at: $apkPath" -ForegroundColor Green
    
    # Ensure Flutter's expected directory exists
    if (-not (Test-Path $flutterApkDir)) {
        New-Item -Path $flutterApkDir -ItemType Directory -Force | Out-Null
    }
    
    # Copy APK to Flutter's expected location
    Copy-Item $apkPath $flutterApkPath -Force
    Write-Host "APK copied to Flutter's expected location: $flutterApkPath" -ForegroundColor Green
    
    # Show file info
    $apkInfo = Get-Item $apkPath
    Write-Host "APK Size: $([math]::Round($apkInfo.Length / 1MB, 2)) MB" -ForegroundColor Cyan
    Write-Host "Build completed successfully!" -ForegroundColor Green
} else {
    Write-Host "Build failed - APK not generated" -ForegroundColor Red
    exit 1
}
