# AI Chat

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.8.1+-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.8.1+-0175C2?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/Platform-Android%20|%20iOS%20|%20Web%20|%20Windows%20|%20Linux%20|%20macOS-blue)

A beautiful, cross-platform AI chat application powered by DeepSeek AI through OpenRouter API.

[Features](#features) • [Installation](#installation) • [Usage](#usage) • [Contributing](#contributing) • [License](#license)

</div>

---

## 📋 Table of Contents

- [About](#about)
- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## 🚀 About

AI Chat is a modern, feature-rich chat application that leverages the power of DeepSeek AI models through the OpenRouter API. Built with Flutter, it provides a seamless experience across multiple platforms including Android, iOS, Web, Windows, Linux, and macOS.

## ✨ Features

- 🤖 **AI-Powered Conversations** - Uses DeepSeek AI for intelligent responses
- 💬 **Real-time Chat** - Instant message streaming
- 🎨 **Beautiful UI** - Modern Material Design with smooth animations
- 📝 **Markdown Support** - Formatted AI responses with code highlighting
- 🌓 **Theme Support** - Light and dark mode
- 📱 **Cross-Platform** - Works on Android, iOS, Web, Windows, Linux, and macOS
- 🔒 **Secure** - API key handling through environment variables
- ⚡ **Fast & Responsive** - Optimized performance with loading states
- 🌐 **Connectivity Check** - Network status monitoring
- ✨ **Smooth Animations** - Engaging user experience with Lottie animations

## 📸 Screenshots

_Add your app screenshots here_

## 📦 Installation

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK (3.8.1 or higher)
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)
- OpenRouter API key ([Get one here](https://openrouter.ai/))

### Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/Shankar-CSE/AI_Chat.git
   cd AI_Chat
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run --dart-define=API_KEY=your_api_key_here
   ```

   Replace `your_api_key_here` with your actual OpenRouter API key.

## 🎯 Usage

### Getting an API Key

1. Visit [OpenRouter](https://openrouter.ai/)
2. Sign up for an account
3. Navigate to API Keys section
4. Create a new API key
5. Copy the key for use in the app

### Running the App

**For Development:**

```bash
flutter run --dart-define=API_KEY=your_api_key_here
```

**For Production (Android):**

```bash
flutter build apk --release --dart-define=API_KEY=your_api_key_here
```

**For Production (iOS):**

```bash
flutter build ios --release --dart-define=API_KEY=your_api_key_here
```

**For Web:**

```bash
flutter build web --release --dart-define=API_KEY=your_api_key_here
```

### Using Environment Variables (Alternative)

You can also set the API key as an environment variable:

**Linux/macOS:**

```bash
export API_KEY=your_api_key_here
flutter run --dart-define=API_KEY=$API_KEY
```

**Windows (PowerShell):**

```powershell
$env:API_KEY="your_api_key_here"
flutter run --dart-define=API_KEY=$env:API_KEY
```

## ⚙️ Configuration

### Dependencies

This project uses the following key dependencies:

- `http` - HTTP client for API calls
- `provider` - State management
- `flutter_markdown` - Markdown rendering
- `connectivity_plus` - Network connectivity
- `animated_text_kit` - Text animations
- `lottie` - Lottie animations
- `shimmer` - Loading effects
- `google_fonts` - Custom fonts

See [pubspec.yaml](pubspec.yaml) for the complete list.

## 🛠️ Development

### Project Structure

```
lib/
├── main.dart              # App entry point
├── screens/               # UI screens
│   ├── chat_screen.dart   # Main chat interface
│   └── splash_screen.dart # Splash screen
├── services/              # Business logic
│   └── chat_service.dart  # API communication
├── theme/                 # App theming
│   └── app_theme.dart     # Theme configuration
└── widgets/               # Reusable widgets
    └── message_bubble.dart # Chat message UI
```

### Running Tests

```bash
flutter test
```

### Code Analysis

```bash
flutter analyze
```

### Code Formatting

```bash
flutter format .
```

### Building for Production

**Android:**

```bash
flutter build apk --release --dart-define=API_KEY=your_api_key
flutter build appbundle --release --dart-define=API_KEY=your_api_key
```

**iOS:**

```bash
flutter build ios --release --dart-define=API_KEY=your_api_key
```

**Web:**

```bash
flutter build web --release --dart-define=API_KEY=your_api_key
```

**Desktop (Windows/Linux/macOS):**

```bash
flutter build windows --release --dart-define=API_KEY=your_api_key
flutter build linux --release --dart-define=API_KEY=your_api_key
flutter build macos --release --dart-define=API_KEY=your_api_key
```

## 🤝 Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

### Quick Contribution Guide

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'feat: add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [OpenRouter](https://openrouter.ai/) for providing the API gateway
- [DeepSeek AI](https://www.deepseek.com/) for the AI model
- [Flutter](https://flutter.dev/) for the amazing framework
- All contributors who help improve this project

## 📞 Support

If you have any questions or need help, please:

- Open an [issue](https://github.com/Shankar-CSE/AI_Chat/issues)
- Check out the [discussions](https://github.com/Shankar-CSE/AI_Chat/discussions)

## 🔐 Security

Please see [SECURITY.md](SECURITY.md) for details on our security policy and how to report vulnerabilities.

## 📈 Roadmap

- [ ] Message search functionality
- [ ] Export chat history
- [ ] Multiple AI model selection
- [ ] Custom themes
- [ ] Voice input support
- [ ] Message reactions
- [ ] Chat history persistence
- [ ] Multi-language support

## ⭐ Star History

If you find this project useful, please consider giving it a star! ⭐

---

<div align="center">

Made with ❤️ using Flutter

</div>
