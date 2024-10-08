# Kotlin Sealed class

Want to manage complex states in your Android apps? Kotlin's `sealed class` is a clean and efficient way to handle it! 

Here's how 👇 #Kotlin #AndroidDev #CodeSmarter

```kotlin
sealed class UiState {
    object Loading : UiState()
    data class Success(val data: String) : UiState()
    data class Error(val message: String) : UiState()
}

fun handleState(state: UiState) {
    when (state) {
        is UiState.Loading -> showLoading()
        is UiState.Success -> showData(state.data)
        is UiState.Error -> showError(state.message)
    }
}
```

