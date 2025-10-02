# Listly Coding Standards

This document captures the conventions and architectural guidelines expected for all code contributions. It is intended for human contributors and AI assistants alike. Every change must respect these rules unless the team agrees on an exception.

## Tooling And Formatting

- Target Dart SDK declared in `pubspec.yaml`; avoid upgrading SDK or dependencies without approval.
- Run `dart format .` before submitting changes and keep files ASCII when possible.
- Do not disable lints from `analysis_options.yaml`; instead, write code that satisfies `package:lint/strict.yaml` and project custom_lints.
- Regenerate code with `dart run build_runner build --delete-conflicting-outputs` whenever Freezed/JSON classes or Riverpod annotations change. Commit generated artifacts when they are tracked.

## Core Principles

- **Null safety first:** All code must be null-safe; prefer `late` only when initialization is guaranteed.
- **Immutability:** Use Freezed for value types and keep UI configuration objects immutable.
- **DRY:** Identify shared logic and extract reusable functions, widgets, or services rather than duplicating logic across features.
- **SOLID:**
  - Single Responsibility – keep files/classes focused on one concern.
  - Open/Closed – extend behaviour through new implementations rather than editing existing stable APIs.
  - Liskov Substitution – implementations must honour the contracts defined by abstractions such as `BaseRepository`.
  - Interface Segregation – define the smallest abstractions that fit each client; avoid forcing consumers to depend on unused members.
  - Dependency Inversion – depend on abstractions and inject implementations via Riverpod providers.

## Project Structure

- `lib/app`: global app concerns (navigation, theming, entry point widgets). Keep public APIs composable and theme-aware.
- `lib/core`: cross-cutting infrastructure utilities (e.g., Sembast service). Consider adding tests under `test/core` when functionality expands.
- `lib/features/<feature>`: group domain, data, and presentation code per feature. Place UI in `presentation/`, interfaces in `domain/`, and data access implementation in `data/`.
- `lib/shared`: reusable utilities such as localization, providers, repositories, and shared widgets.
- `test/`: mirrors the production structure; add tests for new code (unit, widget, or golden as appropriate).

## State Management And Dependency Injection

- Riverpod is the single source for dependency injection. Provide implementations via `Provider`, `NotifierProvider`, or other Riverpod providers and consume them through `ref.watch`/`ref.read`.
- Prefer defining provider instances close to the feature that uses them (e.g., `localShoppingListRepositoryProvider`).
- Avoid global mutable state outside of providers. If state must persist across widgets, create a derived provider or notifier.

## Data Layer Guidelines

- Always code against abstractions (e.g., `ShoppingListRepository`) and keep implementation details inside data layer classes such as `LocalShoppingListRepository`.
- Use the shared `BaseRepository` contract when CRUD semantics apply; extend interfaces for feature-specific operations.
- Wrap database or network calls in try/catch blocks and surface domain-friendly errors or results.
- When mutating entities, prefer creating immutable copies (e.g., `copyWith`) rather than modifying fields in place.

## Presentation And UI

- Build UI widgets that are stateless or `ConsumerWidget` unless local widget state is required.
- Use the centralized theme (`AppTheme.light()` / `AppTheme.dark()`) for consistent styling. Add component builders under `lib/app/theme/components` and corresponding tests under `test/app/theme/components`.
- Ensure UI respects localization and accessibility: use `appLocalization.supportedLocales`, `AppLocalizations`, and semantic widget roles.
- When creating navigation flows, add routes under `lib/app/navigation/routes` and register them in `navigation.dart` via `GoRouter`.

## Localization

- Register new locales or keys in `lib/shared/localization` and ensure translations exist for every supported language.
- Call `appLocalization.ensureInitialized()` (already handled in `main.dart`) before using localized strings at runtime.

## Testing

- For theming and shared components, follow the existing pattern of group-based widget tests (see `test/app/theme/components`).
- Add unit tests for repositories and services that exercise success and failure paths.
- Ensure new Riverpod notifiers/providers have coverage for state transitions and side effects.

## Error Handling And Logging

- Catch and rethrow exceptions with contextual messages at repository/service boundaries. Avoid swallowing exceptions silently.
- Use typed errors or domain models for recoverable failures; reserve generic `Exception` for unexpected conditions.

## Workflow Expectations

- Keep commits scoped and descriptive. Run the full test suite (`flutter test`) before opening a PR.
- Update this document when architectural decisions or conventions change.

