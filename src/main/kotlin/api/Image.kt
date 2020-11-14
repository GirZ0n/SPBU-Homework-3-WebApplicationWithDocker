package api

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class Image(@SerialName("file") val url: String)