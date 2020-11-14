import freemarker.cache.ClassTemplateLoader
import io.ktor.application.Application
import io.ktor.application.call
import io.ktor.application.install
import io.ktor.freemarker.FreeMarker
import io.ktor.freemarker.FreeMarkerContent
import io.ktor.response.respond
import io.ktor.routing.get
import io.ktor.routing.routing
import io.ktor.server.engine.embeddedServer
import io.ktor.server.netty.Netty

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

private const val PORT = 8080

fun main() {
    embeddedServer(Netty, PORT, module = Application::module).start()
}
