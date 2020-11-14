import freemarker.cache.ClassTemplateLoader
import io.ktor.application.*
import io.ktor.freemarker.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*

fun Application.module() {
    install(FreeMarker) {
        templateLoader = ClassTemplateLoader(this::class.java.classLoader, "templates")
    }

    val repo = Repository

    routing {
        get("/") {
            call.respond(FreeMarkerContent("welcome.ftl", emptyMap<String, String>()))
        }

        get("/random/image") {
            call.respond(FreeMarkerContent("randomImage.ftl", mapOf("url" to repo.getRandomImageURL())))
        }

        get("/random/number") {
            call.respond(FreeMarkerContent("randomNumber.ftl", mapOf("number" to repo.getRandomNumber())))
        }

        get("/random/joke") {
            call.respond(FreeMarkerContent("randomJoke.ftl", mapOf("joke" to repo.getRandomJoke())))
        }
    }
}

fun main() {
    embeddedServer(Netty, 8080, module = Application::module).start()
}