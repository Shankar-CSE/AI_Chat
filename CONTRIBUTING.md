# Contributing to AI Chat

First off, thank you for considering contributing to AI Chat! It's people like you that make this project great.

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples to demonstrate the steps**
- **Describe the behavior you observed and what you expected**
- **Include screenshots if applicable**
- **Include your environment details** (OS, Flutter version, device, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

- **Use a clear and descriptive title**
- **Provide a detailed description of the suggested enhancement**
- **Explain why this enhancement would be useful**
- **List any examples of similar features in other apps**

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Follow the Flutter style guide** and existing code conventions
3. **Add tests** if you've added functionality
4. **Update documentation** if needed
5. **Ensure tests pass** by running `flutter test`
6. **Run code analysis** with `flutter analyze`
7. **Format your code** using `flutter format .`
8. **Write clear commit messages** following conventional commits format

#### Commit Message Format

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that don't affect code meaning (formatting, etc.)
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Changes to build process or auxiliary tools

Example:

```
feat(chat): add message search functionality

Implemented search feature that allows users to search through chat history.
- Added search bar in app bar
- Implemented fuzzy search algorithm
- Added highlighting for search results

Closes #123
```

## Development Setup

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK (included with Flutter)
- An IDE (VS Code, Android Studio, or IntelliJ)
- OpenRouter API key

### Getting Started

1. Fork and clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/AI_Chat.git
cd AI_Chat
```

2. Install dependencies:

```bash
flutter pub get
```

3. Create a `.env` file or use dart-define to set your API key:

```bash
flutter run --dart-define=API_KEY=your_api_key_here
```

4. Run the app:

```bash
flutter run
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

## Project Structure

```
lib/
├── main.dart              # App entry point
├── screens/               # UI screens
│   ├── chat_screen.dart
│   └── splash_screen.dart
├── services/              # Business logic & API calls
│   └── chat_service.dart
├── theme/                 # App theming
│   └── app_theme.dart
└── widgets/               # Reusable widgets
    └── message_bubble.dart
```

## Style Guidelines

### Flutter/Dart

- Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide
- Use meaningful variable and function names
- Keep functions small and focused on a single task
- Add comments for complex logic
- Use proper null safety practices

### UI/UX

- Follow Material Design guidelines
- Ensure responsive design for different screen sizes
- Add loading states for async operations
- Provide appropriate error messages
- Test on both Android and iOS

## Questions?

Feel free to open an issue with your question or reach out to the maintainers.

Thank you for contributing! 🎉
