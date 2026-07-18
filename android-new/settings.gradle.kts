pluginManagement {
    includeBuild("miuix/build-plugins")
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
    }
}

rootProject.name = "DaidaiPanel"
include(":app")
include(":miuix:miuix-ui")
include(":miuix:miuix-core")
include(":miuix:miuix-icons")
