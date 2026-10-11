import java.util.Properties

// Wear-OS-App: Kacheln und Komplikationen mit dem Widget-Stand vom Handy.
// Eigenes APK für die Uhr; gleicher Paketname und gleiche Signatur wie die
// Handy-App, sonst stellen die Play-Dienste keine Daten zu.
// Bauen: `flutter build apk` (legt gradlew an), dann `./gradlew :wear:assembleRelease`.
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

val keyPropertiesFile = rootProject.file("key.properties")
val keyProperties = Properties().apply {
    if (keyPropertiesFile.exists()) keyPropertiesFile.inputStream().use { load(it) }
}

// Version aus pubspec.yaml („x.y.z+n“). Der versionCode der Uhr liegt
// fest 1.000.000 über dem der Handy-App, damit beide im selben Store-Eintrag
// eindeutig bleiben.
val pubspecVersion = rootProject.file("../pubspec.yaml").readLines()
    .first { it.startsWith("version:") }
    .substringAfter(":").trim()
val wearVersionName = pubspecVersion.substringBefore("+")
val wearVersionCode = 1_000_000 + (pubspecVersion.substringAfter("+", "1").toIntOrNull() ?: 1)

android {
    namespace = "space.mai.mai_budget_planer.wear"
    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "space.mai.mai_budget_planer"
        // Wear OS 3 und neuer.
        minSdk = 30
        targetSdk = 36
        versionCode = wearVersionCode
        versionName = wearVersionName
    }

    // Format des Widget-Stands nur an einer Stelle pflegen.
    sourceSets["main"].java.srcDir("../app/src/main/kotlin/space/mai/mai_budget_planer/widget/shared")

    if (System.getenv("REQUIRE_RELEASE_SIGNING") == "true" && !keyPropertiesFile.exists()) {
        throw GradleException("REQUIRE_RELEASE_SIGNING is set but android/key.properties is missing")
    }

    signingConfigs {
        if (keyPropertiesFile.exists()) {
            create("release") {
                // Pfad wie in app/build.gradle.kts: relativ zum Modul `app`.
                storeFile = rootProject.file("app").resolve(keyProperties.getProperty("storeFile"))
                storePassword = keyProperties.getProperty("storePassword")
                keyAlias = keyProperties.getProperty("keyAlias")
                keyPassword = keyProperties.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            // Gleicher Schlüssel wie die Handy-App (ohne key.properties: Debug-Key).
            signingConfig = signingConfigs.getByName(
                if (keyPropertiesFile.exists()) "release" else "debug",
            )
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

dependencies {
    implementation("com.google.android.gms:play-services-wearable:19.0.0")
    implementation("androidx.wear.tiles:tiles:1.4.1")
    implementation("androidx.wear.protolayout:protolayout:1.2.1")
    implementation("androidx.wear.watchface:watchface-complications-data-source:1.2.1")
    implementation("androidx.concurrent:concurrent-futures:1.2.0")
}
