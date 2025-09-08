# API Configuration Setup

This project requires API keys to function properly. Follow these steps to set up your API configuration:

## Step 1: Create Your API Config File

1. Navigate to `lib/config/`
2. Copy `api_config.dart.example` and rename it to `api_config.dart`
3. Replace the placeholder values with your actual API keys

## Step 2: Get Your Google Maps API Key

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the following APIs:
   - **Maps Static API** (for displaying location previews)
   - **Geocoding API** (for converting coordinates to addresses)
   - **Maps SDK for Android** (for interactive Google Maps on Android)
   - **Maps SDK for iOS** (for interactive Google Maps on iOS, if building for iOS)
4. Go to **APIs & Services > Credentials**
5. Click **Create Credentials > API Key**
6. Copy your API key and paste it into `lib/config/api_config.dart`

## Step 3: Configure Android Native Integration (Secure Method)

For Google Maps to work on Android, you need to configure the API key securely:

### Method 1: Using local.properties (Recommended - Secure)

1. Open `android/local.properties` 
2. Add this line with your actual API key:
   ```
   GOOGLE_MAPS_API_KEY=YOUR_ACTUAL_API_KEY_HERE
   ```
3. The build system will automatically inject this into AndroidManifest.xml
4. ✅ **This file is git-ignored, so your API key stays secure**

### Method 2: Using Environment Variables (CI/CD)

Set an environment variable:
```bash
export GOOGLE_MAPS_API_KEY=your_actual_api_key_here
```

### ⚠️ Avoid Method 3: Direct in AndroidManifest.xml (Insecure)

**DO NOT** put your API key directly in `AndroidManifest.xml` as it will be committed to version control and visible to anyone with repository access.

## Step 4: Secure Your API Key (Recommended)

1. In the Google Cloud Console, click on your API key to edit it
2. Under **Application restrictions**, choose **Android apps** or **iOS apps**
3. Add your app's package name and SHA-1 fingerprint
4. Under **API restrictions**, select **Restrict key** and choose only the APIs you need

## Important Notes

- ⚠️ **Never commit `api_config.dart` to version control**
- ✅ The file is already added to `.gitignore`
- ✅ Share `api_config.dart.example` with your team, not the actual `api_config.dart`
- 🔒 Keep your API keys secure and don't share them publicly

## File Structure

```
lib/
├── config/
│   ├── api_config.dart.example  ✅ (committed to git)
│   └── api_config.dart          ❌ (ignored by git, contains real keys)
```

## Adding New API Keys

To add new API keys, edit both files:

1. Add the new key to `api_config.dart.example` with a placeholder value
2. Add the new key to `api_config.dart` with your actual API key
3. Import and use `ApiConfig.yourNewApiKey` in your code
