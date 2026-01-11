# Security Policy

## Supported Versions

We release patches for security vulnerabilities. Currently supported versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

We take the security of AI Chat seriously. If you believe you have found a security vulnerability, please report it to us as described below.

### How to Report

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them via email to [INSERT SECURITY EMAIL]. You should receive a response within 48 hours. If for some reason you do not, please follow up via email to ensure we received your original message.

Please include the following information:

- Type of issue (e.g., buffer overflow, SQL injection, cross-site scripting, etc.)
- Full paths of source file(s) related to the manifestation of the issue
- The location of the affected source code (tag/branch/commit or direct URL)
- Any special configuration required to reproduce the issue
- Step-by-step instructions to reproduce the issue
- Proof-of-concept or exploit code (if possible)
- Impact of the issue, including how an attacker might exploit it

### What to Expect

After you submit a report:

1. We will acknowledge your email within 48 hours
2. We will investigate and provide a more detailed response within 7 days
3. We will work with you to understand and resolve the issue
4. Once the issue is resolved, we will publicly acknowledge your responsible disclosure (if you wish)

## Security Best Practices for Users

### API Key Safety

- **Never commit API keys to version control**
- Use environment variables or the `--dart-define` flag to pass API keys
- Rotate API keys regularly
- Use separate API keys for development and production
- Monitor API key usage for suspicious activity

### Application Security

- Keep Flutter SDK and dependencies up to date
- Review permissions requested by the app
- Only download the app from official sources
- Be cautious about what information you share in chat

### For Developers

- Always validate user input
- Use HTTPS for all API communications
- Implement proper error handling that doesn't leak sensitive information
- Follow the principle of least privilege
- Keep dependencies updated and monitor for vulnerabilities
- Use `flutter pub outdated` and `flutter pub upgrade` regularly
- Review code changes carefully before merging

## Known Security Considerations

### API Key Storage

Currently, API keys are passed via command-line arguments or environment variables. For production apps, consider:

- Using Flutter secure storage
- Implementing a backend proxy for API calls
- Using environment-specific configurations

### Data Privacy

- Chat messages are sent to OpenRouter/DeepSeek for processing
- No chat history is stored locally by default
- Review OpenRouter and DeepSeek privacy policies
- Consider implementing local encryption for any stored data

## Security Updates

Security updates will be released as soon as possible after a vulnerability is confirmed. Users will be notified through:

- GitHub Security Advisories
- Release notes
- Project README

## Attribution

We appreciate the security research community and will acknowledge researchers who responsibly disclose vulnerabilities (with their permission).

## Questions

If you have questions about this security policy, please open an issue or contact the maintainers.
