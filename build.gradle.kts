import com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar

plugins {
    application
    kotlin("jvm") version "1.4.10"
    kotlin("plugin.serialization") version "1.4.10"
    id("io.gitlab.arturbosch.detekt") version "1.6.0"
    id("com.github.johnrengelman.shadow") version "6.1.0"
    id("java")
}

application {
    mainClassName = "io.ktor.server.netty.DevelopmentEngine"
}

sourceSets {
    getByName("main").java.srcDirs("src/main/kotlin")
    getByName("main").java.srcDirs("src/test/resources")
}

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
    jcenter()
}

val ktorVersion = "1.4.0"

dependencies {
    detektPlugins("io.gitlab.arturbosch.detekt:detekt-formatting:1.6.0")
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-core:1.0.1")
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.0.1")
    implementation("io.ktor:ktor-client-serialization-jvm:$ktorVersion")
    implementation("io.ktor:ktor-freemarker:$ktorVersion")
    implementation("io.ktor:ktor-server-core:$ktorVersion")
    implementation("io.ktor:ktor-server-netty:$ktorVersion")
    implementation("io.ktor:ktor-client-cio:$ktorVersion")
    implementation(kotlin("stdlib-jdk8"))
}

detekt {
    failFast = true // fail build on any finding
    buildUponDefaultConfig = true // preconfigure defaults
}

tasks {
    compileKotlin {
        kotlinOptions.jvmTarget = "1.8"
    }
    compileTestKotlin {
        kotlinOptions.jvmTarget = "1.8"
    }
}

tasks.withType<ShadowJar> {
    archiveBaseName.set("webApplicationWithDocker")
    archiveClassifier.set("")
    archiveVersion.set("")
}
