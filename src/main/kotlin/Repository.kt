import api.Image
import api.Joke
import io.ktor.client.HttpClient
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.client.request.get
import kotlinx.serialization.json.Json
import kotlin.random.Random

object Repository {
    private val client = HttpClient {
        install(JsonFeature) {
            val jsonSerializer = KotlinxSerializer(Json {
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

    fun getRandomNumber() = Random.nextInt().toString()
}
