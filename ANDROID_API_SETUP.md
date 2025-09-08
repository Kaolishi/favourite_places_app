# Environment Variables Setup (Alternative Approach)

If you want to use environment variables for even more security, follow these steps:

## Step 1: Create local.properties file

Add to `android/local.properties`:
```
GOOGLE_MAPS_API_KEY=AIzaSyAcZ_unS_yHT-1iSgWxowALBKbN--0wwoc
```

## Step 2: Update build.gradle.kts

Add to `android/app/build.gradle.kts`:

```kotlin
// Read API key from local.properties
val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.inputStream().use { localProperties.load(it) }
}

val googleMapsApiKey = localProperties.getProperty("GOOGLE_MAPS_API_KEY") ?: ""

android {
    // ... existing config ...
    
    defaultConfig {
        // ... existing config ...
        manifestPlaceholders["GOOGLE_MAPS_API_KEY"] = googleMapsApiKey
    }
}
```

## Step 3: Update AndroidManifest.xml

```xml
<meta-data android:name="com.google.android.geo.API_KEY"
           android:value="${GOOGLE_MAPS_API_KEY}"/>
```

## Step 4: Update .gitignore

Make sure `android/local.properties` is in .gitignore (it should already be there).

This approach is more complex but provides better separation of environment-specific configuration.
