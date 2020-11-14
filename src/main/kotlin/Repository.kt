import api.Image
import api.Joke
import io.ktor.client.*
import io.ktor.client.features.json.*
import io.ktor.client.features.json.serializer.*
import io.ktor.client.request.*
import java.util.*

object Repository {
    private val client = HttpClient {
        install(JsonFeature) {
            val jsonSerializer = KotlinxSerializer(kotlinx.serialization.json.Json {
                ignoreUnknownKeys = true
                isLenient = true
            })

            serializer = jsonSerializer
        }
    }

    suspend fun getRandomImageURL(): String {
        val image = client.get<Image>("https://loremflickr.com/json/500/500")
        return image.url
    }

    suspend fun getRandomJoke(): String {
        val joke = client.get<Joke>("https://api.chucknorris.io/jokes/random")
        return joke.value
    }

    fun getRandomNumber() = Random().nextInt().toString()
}