# Week 1: Data Layer + Authentication - Task Checklist

**Timeline**: Days 1-7  
**Goal**: Build solid foundation - all data repositories and authentication  
**Started**: [Date]  
**Completed**: [Date]

---

## 📋 Overview

By end of Week 1, you will have:
- ✅ Complete Shopping Items repository
- ✅ User authentication (email + Google)
- ✅ Cloud sync working (basic)
- ✅ Auth UI screens
- ✅ Foundation ready for building UI in Week 2

---

## Day 1-2: Shopping Items Repository

**Estimated Time**: 8-12 hours total

### Domain Layer
- [ ] Create `ShoppingItemRepository` interface
  - [ ] Create file: `lib/features/shopping_list/domain/repositories/shopping_item_repository.dart`
  - [ ] Define abstract methods:
    - [ ] `Future<ShoppingItem?> getById(String id)`
    - [ ] `Future<List<ShoppingItem>> getAll()`
    - [ ] `Future<List<ShoppingItem>> getItemsByListId(String listId)`
    - [ ] `Future<void> create(ShoppingItem item)`
    - [ ] `Future<void> update(ShoppingItem item)`
    - [ ] `Future<void> delete(String id)`
    - [ ] `Future<void> toggleCompleted(String id)`
    - [ ] `Stream<List<ShoppingItem>> watchItemsByListId(String listId)`
    - [ ] `Stream<ShoppingItem?> watchById(String id)`

### Data Layer
- [ ] Implement `LocalShoppingItemRepository`
  - [ ] Create file: `lib/features/shopping_list/data/repositories/local_shopping_item_repository.dart`
  - [ ] Import dependencies (SembastService, ShoppingItem model)
  - [ ] Define store name: `shopping_items`
  - [ ] Implement `getById()` method
  - [ ] Implement `getAll()` method
  - [ ] Implement `getItemsByListId()` with Finder filter
  - [ ] Implement `create()` method
  - [ ] Implement `update()` method (with updatedAt timestamp)
  - [ ] Implement `delete()` method
  - [ ] Implement `toggleCompleted()` method
  - [ ] Implement `watchItemsByListId()` stream
  - [ ] Implement `watchById()` stream
  - [ ] Add error handling (try-catch blocks)

### Provider
- [ ] Create Riverpod provider
  - [ ] Create file: `lib/features/shopping_list/data/providers/shopping_item_provider.dart`
  - [ ] Define `localShoppingItemRepositoryProvider`
  - [ ] Wire up dependencies (SembastService)

### Testing
- [ ] Write unit tests
  - [ ] Create file: `test/features/shopping_list/data/repositories/local_shopping_item_repository_test.dart`
  - [ ] Test `create()` - should store item
  - [ ] Test `getById()` - should return item
  - [ ] Test `getById()` - should return null for non-existent
  - [ ] Test `getAll()` - should return all items
  - [ ] Test `getItemsByListId()` - should filter by listId
  - [ ] Test `update()` - should update item
  - [ ] Test `delete()` - should remove item
  - [ ] Test `toggleCompleted()` - should toggle isCompleted
  - [ ] Test `watchItemsByListId()` - should emit updates
  - [ ] Run tests: `flutter test test/features/shopping_list/data/repositories/local_shopping_item_repository_test.dart`

### Code Generation
- [ ] Run code generation if needed
  - [ ] `dart run build_runner build --delete-conflicting-outputs`

### Commit
- [ ] Commit your work
  - [ ] `git add .`
  - [ ] `git commit -m "feat: implement ShoppingItemRepository with local storage"`

**✅ Day 1-2 Complete**: Shopping items can be stored, retrieved, and watched locally

---

## Day 3-4: Authentication System

**Estimated Time**: 10-14 hours total

### Domain Layer
- [ ] Create `UserRepository` interface
  - [ ] Create file: `lib/shared/repositories/user_repository.dart`
  - [ ] Define abstract methods:
    - [ ] `Future<User?> getCurrentUser()`
    - [ ] `Future<User?> getUserById(String id)`
    - [ ] `Future<void> createUser(User user)`
    - [ ] `Future<void> updateUser(User user)`
    - [ ] `Stream<User?> watchCurrentUser()`

### Data Layer - Local User Repository
- [ ] Implement `LocalUserRepository` (cache)
  - [ ] Create file: `lib/shared/data/repositories/local_user_repository.dart`
  - [ ] Store name: `users`
  - [ ] Store key for current user: `current_user`
  - [ ] Implement `getCurrentUser()` - read from cache
  - [ ] Implement `getUserById()` - read from cache
  - [ ] Implement `createUser()` - store to cache
  - [ ] Implement `updateUser()` - update cache
  - [ ] Implement `watchCurrentUser()` - stream from cache

### Data Layer - Firebase User Repository
- [ ] Implement `FirebaseUserRepository`
  - [ ] Create file: `lib/shared/data/repositories/firebase_user_repository.dart`
  - [ ] Firestore collection: `users`
  - [ ] Implement `getUserById()` - fetch from Firestore
  - [ ] Implement `createUser()` - save to Firestore
  - [ ] Implement `updateUser()` - update Firestore
  - [ ] Add error handling for network failures

### Authentication Service
- [ ] Create `AuthService`
  - [ ] Create file: `lib/shared/services/auth_service.dart`
  - [ ] Initialize Firebase Auth instance
  - [ ] Implement `signInWithEmail(email, password)`
    - [ ] Call Firebase Auth signInWithEmailAndPassword
    - [ ] On success, create/update User in repositories
    - [ ] Return User or throw error
  - [ ] Implement `signUpWithEmail(email, password, name)`
    - [ ] Call Firebase Auth createUserWithEmailAndPassword
    - [ ] Create User object from firebase_auth.User
    - [ ] Save to both local and Firebase repositories
    - [ ] Return User
  - [ ] Implement `signInWithGoogle()`
    - [ ] Initialize GoogleSignIn
    - [ ] Get GoogleSignInAccount
    - [ ] Get authentication
    - [ ] Create Firebase credential
    - [ ] Sign in with credential
    - [ ] Create User from firebase_auth.User
    - [ ] Save to repositories
    - [ ] Return User
  - [ ] Implement `signOut()`
    - [ ] Call Firebase Auth signOut
    - [ ] Clear local user cache
  - [ ] Implement `deleteAccount()`
    - [ ] Delete user from Firestore
    - [ ] Delete from local cache
    - [ ] Delete Firebase Auth user
  - [ ] Add error handling and user-friendly error messages

### Authentication State Provider
- [ ] Create auth state notifier
  - [ ] Create file: `lib/shared/providers/auth/auth_provider.dart`
  - [ ] Use Riverpod `StreamNotifier` or `AsyncNotifier`
  - [ ] Watch Firebase Auth state changes: `FirebaseAuth.instance.authStateChanges()`
  - [ ] Return current User or null
  - [ ] Provide methods: `signIn()`, `signUp()`, `signOut()`

### Testing
- [ ] Write auth service tests
  - [ ] Create file: `test/shared/services/auth_service_test.dart`
  - [ ] Mock Firebase Auth (using mockito)
  - [ ] Test successful email sign-in
  - [ ] Test failed email sign-in (wrong password)
  - [ ] Test successful sign-up
  - [ ] Test sign-out
  - [ ] Run tests: `flutter test test/shared/services/auth_service_test.dart`

### Dependencies
- [ ] Add required dependencies to `pubspec.yaml`
  - [ ] Check if `google_sign_in: ^6.1.5` is needed (for Google auth)
  - [ ] Run `flutter pub get` if added

### Commit
- [ ] Commit authentication system
  - [ ] `git add .`
  - [ ] `git commit -m "feat: implement authentication with email and Google sign-in"`

**✅ Day 3-4 Complete**: Authentication system working, users can sign in/up/out

---

## Day 5-6: Cloud Sync (Basic)

**Estimated Time**: 10-14 hours total

### Firebase Shopping List Repository
- [ ] Implement `FirebaseShoppingListRepository`
  - [ ] Create file: `lib/features/shopping_list/data/repositories/firebase_shopping_list_repository.dart`
  - [ ] Firestore collection: `shopping_lists`
  - [ ] Implement `getById(id)` - fetch from Firestore
  - [ ] Implement `getAll()` - Not used (user-specific only)
  - [ ] Implement `getUserLists(userId)` - query where creatorUserId == userId
  - [ ] Implement `create(list)` - save to Firestore
  - [ ] Implement `update(list)` - update Firestore document
  - [ ] Implement `delete(id)` - delete from Firestore
  - [ ] Implement `archiveList(id)` - update isArchived field
  - [ ] Implement `watchById(id)` - stream from Firestore
  - [ ] Implement `watchUserLists(userId)` - stream user's lists
  - [ ] Add error handling (network failures)

### Firebase Shopping Item Repository
- [ ] Implement `FirebaseShoppingItemRepository`
  - [ ] Create file: `lib/features/shopping_list/data/repositories/firebase_shopping_item_repository.dart`
  - [ ] Firestore collection: `shopping_items`
  - [ ] Implement `getById(id)` - fetch from Firestore
  - [ ] Implement `getItemsByListId(listId)` - query where listId == listId
  - [ ] Implement `create(item)` - save to Firestore
  - [ ] Implement `update(item)` - update Firestore
  - [ ] Implement `delete(id)` - delete from Firestore
  - [ ] Implement `toggleCompleted(id)` - update isCompleted
  - [ ] Implement `watchItemsByListId(listId)` - stream items for list
  - [ ] Add error handling

### Sync Strategy Implementation
- [ ] Create unified repository (combines local + Firebase)
  - [ ] Create file: `lib/features/shopping_list/data/repositories/shopping_list_repository_impl.dart`
  - [ ] Inject both LocalShoppingListRepository and FirebaseShoppingListRepository
  - [ ] **Write strategy**: Write to local first, then Firebase in background
  - [ ] Implement `create()`:
    - [ ] Save to local immediately
    - [ ] Try to save to Firebase
    - [ ] If Firebase fails, queue for retry (simple, just log for now)
  - [ ] Implement `update()`:
    - [ ] Update local immediately
    - [ ] Try to update Firebase
  - [ ] **Read strategy**: Read from local for speed
  - [ ] Implement `getUserLists()`:
    - [ ] Read from local
    - [ ] In background: Fetch from Firebase and merge
  - [ ] **Watch strategy**: Watch both sources
  - [ ] Implement `watchUserLists()`:
    - [ ] Merge streams from local and Firebase
    - [ ] Use `StreamGroup.merge()` or similar
  - [ ] **Conflict resolution**: Last write wins (compare updatedAt)

- [ ] Create unified item repository
  - [ ] Create file: `lib/features/shopping_list/data/repositories/shopping_item_repository_impl.dart`
  - [ ] Same strategy as shopping list repository
  - [ ] Write to local first, then Firebase
  - [ ] Read from local for speed
  - [ ] Watch both sources

### Firestore Security Rules
- [ ] Update Firestore security rules
  - [ ] Open Firebase Console → Firestore → Rules
  - [ ] Add rule: Users can only read/write their own lists
  ```
  rules_version = '2';
  service cloud.firestore {
    match /databases/{database}/documents {
      // Shopping Lists
      match /shopping_lists/{listId} {
        allow read, write: if request.auth != null && 
                             resource.data.creatorUserId == request.auth.uid;
      }
      
      // Shopping Items
      match /shopping_items/{itemId} {
        allow read, write: if request.auth != null;
        // TODO v1.1: Check if user has access to parent list
      }
      
      // Users
      match /users/{userId} {
        allow read, write: if request.auth != null && 
                             request.auth.uid == userId;
      }
    }
  }
  ```
  - [ ] Publish rules
  - [ ] Test rules work (create list, should sync to Firestore)

### App Initialization - Sync on Startup
- [ ] Update main.dart to load data on startup
  - [ ] After auth check, if user authenticated:
    - [ ] Fetch user's lists from Firebase
    - [ ] Merge with local lists
    - [ ] Save to local (so they're available offline)

### Testing
- [ ] Manual testing (requires Firebase connection)
  - [ ] Sign in
  - [ ] Create a list → check Firestore console (should appear)
  - [ ] Add items → check Firestore (should appear)
  - [ ] Enable airplane mode
  - [ ] Create list offline → should save locally
  - [ ] Disable airplane mode
  - [ ] Wait a moment → list should sync to Firestore
  - [ ] Open app on different device (or clear local data)
  - [ ] Sign in → should load lists from Firestore

### Commit
- [ ] Commit sync implementation
  - [ ] `git add .`
  - [ ] `git commit -m "feat: implement basic cloud sync for lists and items"`

**✅ Day 5-6 Complete**: Data syncs between local and Firebase, offline-first working

---

## Day 7: Authentication UI

**Estimated Time**: 6-8 hours total

### Welcome/Splash Screen
- [ ] Create `WelcomeScreen`
  - [ ] Create file: `lib/features/auth/presentation/screens/welcome_screen.dart`
  - [ ] Show app logo
  - [ ] App name "Listly"
  - [ ] Tagline: "Smart shopping lists for everyone"
  - [ ] "Get Started" button → navigate to Sign In
  - [ ] "Create Account" button → navigate to Sign Up
  - [ ] Nice gradient background or illustration
  - [ ] Use theme colors

### Sign In Screen
- [ ] Create `SignInScreen`
  - [ ] Create file: `lib/features/auth/presentation/screens/sign_in_screen.dart`
  - [ ] Email TextField (with email keyboard type)
  - [ ] Password TextField (obscured, with toggle visibility)
  - [ ] "Sign In" button
  - [ ] "Forgot Password?" link (can be empty action for v1.0)
  - [ ] Divider with "OR"
  - [ ] "Sign in with Google" button
  - [ ] "Don't have an account? Sign up" link → navigate to Sign Up
  - [ ] Form validation:
    - [ ] Email format validation
    - [ ] Password not empty
  - [ ] Loading state (CircularProgressIndicator) during sign-in
  - [ ] Error handling:
    - [ ] Show SnackBar for errors
    - [ ] User-friendly messages ("Invalid email or password")
  - [ ] On successful sign-in → navigate to home screen

### Sign Up Screen
- [ ] Create `SignUpScreen`
  - [ ] Create file: `lib/features/auth/presentation/screens/sign_up_screen.dart`
  - [ ] Name TextField
  - [ ] Email TextField
  - [ ] Password TextField (obscured)
  - [ ] Confirm Password TextField
  - [ ] "Create Account" button
  - [ ] Divider with "OR"
  - [ ] "Sign up with Google" button
  - [ ] "Already have an account? Sign in" link → navigate to Sign In
  - [ ] Form validation:
    - [ ] Name not empty
    - [ ] Email format valid
    - [ ] Password min 6 characters
    - [ ] Passwords match
  - [ ] Loading state during sign-up
  - [ ] Error handling (email already in use, weak password, etc.)
  - [ ] On successful sign-up → navigate to home screen

### Navigation Integration
- [ ] Update app navigation
  - [ ] Edit `lib/app/navigation/navigation.dart`
  - [ ] Add auth routes:
    - [ ] `/welcome` - WelcomeScreen
    - [ ] `/sign-in` - SignInScreen
    - [ ] `/sign-up` - SignUpScreen
  - [ ] Update initial location logic:
    - [ ] If user NOT authenticated → show `/welcome`
    - [ ] If user authenticated → show `/` (home)
  - [ ] Use `redirect` in GoRouter to check auth state

### Auth State Handling in Main App
- [ ] Update `MainApp` in main.dart
  - [ ] Watch auth state provider
  - [ ] If user is null → show auth screens
  - [ ] If user exists → show app scaffold with navigation

### Localization
- [ ] Add auth strings to localization
  - [ ] Edit `lib/shared/localization/en_translations.dart`
  - [ ] Add keys: `auth.signIn`, `auth.signUp`, `auth.email`, `auth.password`, etc.
  - [ ] Edit `lib/shared/localization/fr_translations.dart`
  - [ ] Add French translations

### Testing
- [ ] Manual testing
  - [ ] Start app → should see Welcome screen
  - [ ] Tap "Get Started" → should see Sign In
  - [ ] Try sign in with invalid credentials → should show error
  - [ ] Tap "Sign up" → should see Sign Up screen
  - [ ] Sign up with new account → should work and navigate to home
  - [ ] Close app, reopen → should remember user (auto sign-in)
  - [ ] Sign out (from settings when built) → should return to Welcome

### Polish
- [ ] Add smooth animations
  - [ ] Page transitions
  - [ ] Button press feedback
  - [ ] Loading indicators
- [ ] Check both light and dark themes
- [ ] Test on small screen (iPhone SE) and large (iPad)

### Commit
- [ ] Commit auth UI
  - [ ] `git add .`
  - [ ] `git commit -m "feat: add authentication UI screens (welcome, sign in, sign up)"`

**✅ Day 7 Complete**: Auth UI working, users can sign up, sign in, and use the app

---

## Week 1 Final Checklist

### Code Quality
- [ ] All files formatted: `dart format .`
- [ ] No linter errors: `dart analyze`
- [ ] All tests passing: `flutter test`
- [ ] Code generation run if needed: `dart run build_runner build --delete-conflicting-outputs`

### Git
- [ ] All work committed
- [ ] Descriptive commit messages
- [ ] Optional: Create PR or push to remote

### Documentation
- [ ] Update progress in IMPLEMENTATION_PLAN.md (mark Week 1 complete)
- [ ] Add any notes or learnings

### Testing on Devices
- [ ] Test on iOS device or simulator
- [ ] Test on Android device or emulator
- [ ] Test offline mode works
- [ ] Test sync works when online

### Preparation for Week 2
- [ ] Review Week 2 tasks (Lists UI)
- [ ] Ensure Firebase is set up correctly
- [ ] Clear any blockers

---

## 🎉 Week 1 Complete!

**Achievements:**
- ✅ Complete data layer for items
- ✅ Authentication system working
- ✅ Cloud sync functional
- ✅ Auth UI complete
- ✅ Ready to build the actual shopping list screens

**Next**: Week 2 - Core List UI (Lists screen, create/edit lists, list detail, add items)

---

## Notes & Learnings

*Use this space to track issues, solutions, or ideas:*

- 
- 
- 

---

**Last Updated**: [Date]  
**Status**: [ ] Not Started | [ ] In Progress | [ ] Complete

