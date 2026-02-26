# LARA AI - Companion

An elegant, reactive AI assistant built with Flutter and Gemini. Features Clean Architecture, Riverpod state management, and robust offline-first local persistence. 🚀✨

## How to start the repository

### Install flutter

If you don't have the basic development environment tools and Flutter installed, you'll need to follow the Flutter installation guide.

For more details, see:
    - https://docs.flutter.dev/get-started/install

<blockquote style="font-size: 0.9em; color: grey; font-style: italic;">
📌 Last flutter version tested: 3.41.2
</blockquote>

### Clone repository and get dependencies

```bash
$ git clone https://github.com/marcelomfranca/lara_ai_companion.git
$ cd lara_ai_companion/
$ flutter pub get --no-example
```

## Riverpod - A Reactive Caching and Data-binding Framework

To manage the UI states, we use Riverpod – a framework that not only handles state management but also extends Provider, allowing state access in various parts of the application.

"Allows easily accessing that state in multiple locations. Providers are a complete replacement for patterns like Singletons, Service Locators, Dependency Injection or InheritedWidgets."

To generate the Riverpod code, use the following command:

```bash
$ dart run build_runner build --delete-conflicting-outputs
```

"When using Riverpod, code generation is completely optional. It is entirely possible to use Riverpod without. At the same time, Riverpod embraces code generation and recommends using it."

For more details, see: https://riverpod.dev/

### Firebase setup

Configure your firebase project and get the google-services.json file. Put it in android/app/ path.

For more details, see https://firebase.google.com/docs/flutter/setup?hl=pt-br&platform=ios

Check the flutter fire docs too: https://firebase.flutter.dev/docs/overview

### Gemini integration

Configure you firebase project with gemini and create an API Key, remember to select the model 2.5 Flash in build session.

Configure your api key in core_app.dart file.

For more details https://aistudio.google.com/

## Code organization

```
lib/src/
    main.dart                   # main dart/flutter application
    firebase_options.dart       # firebase auto generated options file
    src/                        # source code
        app/                    # main flutter widget
            | routing           # app router implementation
        core/                   # the code shared through the entire application
        features/               # the code of individual features
            | ai/               # lara ai module code
            | auth/             # auth module code
            ... [module_name]_module.dart    # module name and routes
```

The feature-first concept was adopted in the project's organisation. This means that each feature follows the same structure proposed by the architecture.

## Architecture Overview

Clean architecture was used, following a feature-first approach to structure the project while ensuring a clear separation of responsibilities.

The Clean architecture model applied is the same one proposed by Andrea:

<p align="center">
  <img src="https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/images/flutter-app-architecture.webp" alt="Participy - Event planning app" width="300">
</p>

The domain layer is the core of the application and should contain only pure business rules and abstractions, which include:

- Entities (business models that have identity and logic)
- Contracts/Interfaces (abstractions for repositories, services, etc.)
- Enums that are part of the domain logic
- Errors/Exceptions specific to the business rules
- Configurations that directly impact the domain logic (such as constants related to business logic rather than infrastructure)

For more details, see: https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/

## Gitflow workflow

We are using the GitFlow workflow to organise the code development. This approach helps to streamline the process, ensures clear version management, and facilitates collaboration among team members. The branching model defines separate branches for features, releases, and hotfixes, making it easier to maintain a stable codebase while developing new features and resolving issues.

"Each new feature should reside in its own branch, which can be pushed to the central repository for backup/collaboration. But, instead of branching off of main, feature branches use develop as their parent branch. When a feature is complete, it gets merged back into develop. Features should never interact directly with main."

<p align="center">
  <img src="https://wac-cdn.atlassian.com/dam/jcr:34c86360-8dea-4be4-92f7-6597d4d5bfae/02%20Feature%20branches.svg?cdnVersion=2634" alt="Girflow - feature branches" height="350">
</p>

For more details, see: https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow

## Features

- Auth - firebase auth with email/password and google sigin
- Ai - gemini integration via API

## Key Features

### Dynamic Personality Settings
Take full control over Lara's behavior through a dedicated settings suite:
* **Tone & Humor:** Adjust the personality spectrum from professional to witty/humorous.
* **Response Verbosity:** Toggle between concise answers and detailed, in-depth explanations.
* **Localization:** Multi-language support to interact in your preferred tongue.

### ⚡ Robust Error Handling & Offline Mode
Built to be resilient in any network condition:
* **Offline First:** Access chat history without an active connection.
* **Smart Retry Logic:** On demand re-transmission attempts for failed requests.
* **Error Mapping:** Comprehensive handling error structure

### Quality Assurance

* **Unit Testing:** Simple test example

### Design & Accessibility
A premium experience for every user:
* **Adaptive Dark Mode:** A high-contrast, navy-inspired dark theme designed for reduced eye strain.
* **Accessibility First:** * Flexible layouts that prevent **overflows** even with large system font scales.