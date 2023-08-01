# Runatal

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Swift](https://img.shields.io/badge/Swift-5.8-orange.svg)](https://swift.org/)

Runatal is a comprehensive application that provides detailed information about the Elder Futhark, the oldest form of the runic alphabets. The application is available on iOS, iPadOS, macOS, and Apple Watch, and supports translations in English and Russian.

## Features ✨

 - Comprehensive Information: Runatal includes the symbol, name, meaning, sound, and associated poems for each rune in the Elder Futhark.
 - Multi-Language Support: The application supports translations of rune meanings and rune poems in English and Russian.
 - Cross-Platform Compatibility: Runatal is compatible with iOS, iPadOS, macOS, and Apple Watch, providing a seamless user experience across devices.
 - Intuitive User Interface: The application features a beautiful and intuitive user interface, making it easy for users to navigate and find information.


## Installation 💻

For developers who want to run the project locally:

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Choose the desired target (macOS, iOS, iPadOS, or watchOS).
4. Press the Run button or use the `Cmd+R` shortcut to build and run the project.

## Usage 📖

After launching the app, you will see a list of runes. Select a rune to view its details. You can also change the translation language in the settings.

## Code Structure 🏗️

```
Runatal
│
├── .github/workflows
│   └── main.yml  # GitHub Actions workflow configuration file
│
├── Source  # Main source code of the application
│   ├── Controllers  # Contains the main controller
│   │   └── RunesController.swift  # Controller for managing the state and behavior of the runes
│   │
│   ├── Models  # Contains the data models
│   │   ├── Rune.swift  # Model representing a rune
│   │   └── RunePoem.swift  # Model representing a rune poem
│   │
│   ├── Views  # Contains the SwiftUI views
│   │   ├── RuneDetailView.swift  # View for displaying the details of a rune
│   │   ├── RunePoemView.swift  # View for displaying the details of a rune poem
│   │   └── RunesView.swift  # View for displaying the list of runes
│   │
│   └── RunatalApp.swift  # Main entry point of the application
│
├── WatchOsApp  # Contains the source code for the watchOS version of the app
│   ├── RunatalWatchOsApp.swift  # Main entry point of the watchOS application
│   └── RuneListView.swift  # View for displaying the list of runes in the watchOS app
│
├── Tests  # Contains the unit tests for the application
│   ├── UnitTests  # Contains the unit test cases
│   │   ├── RunePoemUnitTests.swift  # Test cases for the RunePoem model
│   │   ├── RuneUnitTests.swift  # Test cases for the Rune model
│   │   └── RunesControllerTests.swift  # Test cases for the RunesController
│
├── LICENSE  # File containing the license for the project
└── README.md  # Markdown file containing information about the project
```

## Contributing 🤝

Contributions to the Runatal app are very welcome! Whether it's reporting bugs, suggesting new features, improving documentation, or contributing code, we appreciate all forms of help.

Here's how you can contribute:

1. **Reporting Bugs**: If you find a bug, please open an issue in the GitHub repository. Be sure to include a detailed description of the bug and steps to reproduce it.

2. **Suggesting Features**: Have an idea for a new feature? Open an issue and describe your idea. Be as detailed as possible.

3. **Improving Documentation**: Good documentation makes a great project even better. If you see a place where the documentation could be improved, please open an issue or submit a pull request.

4. **Contributing Code**: If you'd like to contribute code, please fork the repository, make your changes, and submit a pull request. Please make sure your code follows the existing style for consistency.

Thank you for helping to improve the Runatal app!


## License 📜

This project is licensed under the [MIT License](LICENSE).

## Credits 🙏

The Runatal app was created by [Andrey Skurlatov](https://andskur.github.io), a passionate developer with an interest in languages and history.

This project wouldn't be possible without the following resources:

- [Swift](https://swift.org/): The powerful and intuitive programming language for macOS, iOS, watchOS, and tvOS.
- [OpenAI](https://openai.com/): For providing the AI model that helped in code improvements and documentation.

## Contact 📬

If you have any questions, comments, or suggestions about the Runatal app, we'd love to hear from you! Here's how you can reach us:

- **GitHub**: Open an issue in the [Runatal repository](https://github.com/andskur/Runatal/issues) for any bugs, feature suggestions, or questions about the code.
- **Email**: You can reach us at [a.skurlatov@gmail.com](mailto:a.skurlatov@gmail.com) for any other inquiries.

We look forward to hearing from you!
