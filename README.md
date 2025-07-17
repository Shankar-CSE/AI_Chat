# AI Chat App

A Flutter application that uses the DeepSeek AI model through OpenRouter API.

## Setup

To run this application, you need to provide your OpenRouter API key:

```bash
flutter run --dart-define=API_KEY=your_api_key_here
```

Replace `your_api_key_here` with your actual OpenRouter API key.

## Security Note

Never commit API keys to version control. The app is configured to use environment variables for sensitive information.