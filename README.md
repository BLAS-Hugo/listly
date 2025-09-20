# Listly

A Flutter-based grocery shopping list application that allows users to create, manage, and share shopping lists collaboratively.

## Features

- **Create Shopping Lists**: Build custom grocery lists with items
- **List Management**: Add, remove, and update items in your lists
- **Collaborative Sharing**: Share lists with participants for real-time collaboration
- **Multiple Sharing Options**: Share via direct participant invitation, shareable links, or QR codes
- **Offline-First**: Lists are stored locally first, then synced with Firebase
- **Multi-Device Sync**: Access your lists across different devices
- **Real-time Updates**: See changes from other participants instantly

## Architecture

- **Frontend**: Flutter with Riverpod state management
- **Backend**: Firebase (Firestore, Auth, Messaging, Crashlytics)
- **Local Storage**: Sembast for offline functionality
- **Data Models**: Freezed for immutable data classes
