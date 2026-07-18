pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://maven.pkg.github.com/compose-miuix-ui/miuix")
            credentials {
                username = System.getenv("GITHUB_ACTOR") ?: "public"
                password = System.getenv("GITHUB_TOKEN") ?: ""
            }
        }
        maven {
            url = uri("https://jitpack.io")
        }
    }
}

rootProject.name = "DaidaiPanel"
include(":app")
