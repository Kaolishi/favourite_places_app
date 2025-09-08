allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Commented out custom build directory configuration to prevent path conflicts
// If you need custom build directories, consider using standard Gradle approaches
// val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
// rootProject.layout.buildDirectory.value(newBuildDir)

// subprojects {
//     // Exclude Flutter plugins from custom build directory to avoid path conflicts
//     // These plugins have their own build directory requirements
//     val excludedPlugins = listOf(
//         "path_provider_android",
//         "location", 
//         "google_maps_flutter_android",
//         "image_picker_android"
//     )
//     
//     if (!excludedPlugins.any { project.name.contains(it) }) {
//         val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
//         project.layout.buildDirectory.value(newSubprojectBuildDir)
//     }
// }

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
