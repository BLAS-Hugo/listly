# Listly - Implementation Plan

**Document Version**: 2.0.0  
**Last Updated**: 2025-10-27  
**Status**: Active - Accelerated 4-Week MVP  
**Developer**: Solo (with AI assistance)  
**Availability**: Full-time

---

## ⚠️ CRITICAL: Scope Discipline

**ZERO TOLERANCE FOR SCOPE CREEP**

This plan defines **v1.0** (4 weeks) and **v1.1** (2 weeks post-launch) with strict feature boundaries. 

**If you want to add ANY feature not explicitly listed:**
1. ❌ **DO NOT add it to v1.0 or v1.1**
2. ✅ **Defer it to v1.2+ and document it**
3. ✅ **Ship v1.0 first, validate with users**
4. ✅ **Then decide what goes in v1.2**

**Why this matters:**
- Every "small feature" adds 1-3 days
- Scope creep is the #1 killer of side projects
- Ship fast → get feedback → iterate
- Perfect is the enemy of shipped

**Rule**: If it's not in the "Version Definitions" section below, it doesn't get built until after v1.1.

---

## Version Definitions

### v1.0 - Core Single-User MVP (Week 1-4)

**Tagline**: "Personal shopping lists that work offline"

**Scope**: Single-user shopping list app with cloud backup
- ✅ User authentication (email + Google)
- ✅ Create, edit, delete shopping lists
- ✅ Add, edit, check-off, delete items
- ✅ Offline-first with automatic cloud sync
- ✅ Categories and organization
- ✅ Settings (profile, theme, language)
- ✅ Onboarding flow

**Explicitly Excluded from v1.0:**
- ❌ List sharing / collaboration
- ❌ Notifications
- ❌ Advanced features (analytics, AI, photos, export)
- ❌ Monetization (ads, IAP)
- ❌ QR codes, links, templates
- ❌ Voice input, location features
- ❌ "Wouldn't it be cool if..." features

**Timeline**: 4 weeks  
**Launch Strategy**: Public launch to App Store & Play Store

---

### v1.1 - Collaboration & Polish (Week 5-6, Post-Launch)

**Tagline**: "Share lists with family and friends"

**Scope**: Add sharing while fixing launch bugs
- ✅ Share lists with other users (by email/user ID)
- ✅ Real-time collaboration (multiple users editing same list)
- ✅ View and manage list participants
- ✅ Permission checks (creator vs. participant)
- ✅ Push notifications (added to list, items changed)
- ✅ Bug fixes from v1.0 user feedback
- ✅ Performance improvements based on real usage
- ✅ UI/UX tweaks from user feedback

**Timeline**: 2 weeks (during/after v1.0 store review)  
**Launch Strategy**: App update

---

### v1.2+ - Feature Backlog (Future)

**Everything else goes here** - defer all "nice-to-have" features:
- Monetization (Phase 2: ads, IAP, premium tier)
- AI features (Phase 3)
- Advanced sharing (QR codes, public links)
- Analytics dashboard
- Item photos
- Export features
- Templates
- Voice input
- Location reminders
- And ANY other ideas you have during development

**When to plan v1.2**: After v1.1 ships and you have user feedback

---

## Executive Summary

This document outlines an **accelerated 4-week MVP plan** for Listly. The strategy is to ship a polished single-user app quickly (v1.0), add sharing immediately after (v1.1), then iterate based on real user feedback (v1.2+).

---

## Current State Assessment

### ✅ What's Already Built

**Infrastructure (80% Complete)**:
- ✅ Flutter project structure with proper organization
- ✅ Firebase integration (Auth, Firestore, Messaging, Crashlytics)
- ✅ Sembast local database setup
- ✅ Riverpod state management infrastructure
- ✅ GoRouter navigation with bottom nav shell
- ✅ Theme system (light/dark, Material Design 3)
- ✅ Localization system (English, French)
- ✅ Build tooling (code generation, freezed, json_serializable)

**Data Layer (70% Complete)**:
- ✅ Core domain models (ShoppingList, ShoppingItem, User, ListPermissions)
- ✅ Freezed immutable data classes with JSON serialization
- ✅ BaseRepository abstraction
- ✅ ShoppingListRepository interface
- ✅ LocalShoppingListRepository implementation (Sembast)
- ✅ SembastService with CRUD and Stream operations
- ✅ Comprehensive unit tests for models and repositories

**UI Foundation (30% Complete)**:
- ✅ App shell with bottom navigation
- ✅ Theme components (buttons, cards, inputs, etc.)
- ✅ Placeholder debug screens
- ⚠️ No actual list/item management UI yet
- ⚠️ No authentication UI
- ⚠️ No sharing UI

**Missing**:
- ❌ Shopping item repository
- ❌ User repository & authentication flow
- ❌ Firebase repository implementations (cloud sync)
- ❌ All presentation layer screens (list view, item management, settings, etc.)
- ❌ Sync service (local → cloud)
- ❌ Monetization (ads, IAP)
- ❌ AI features

---

## Overall Strategy

**Approach**: Ship fast, iterate based on feedback
- **v1.0** (4 weeks): Single-user MVP
- **v1.1** (2 weeks): Add collaboration
- **v1.2+** (future): Monetization, AI, advanced features

**Why This Order:**
1. **v1.0**: Proves core value (personal shopping lists)
2. **v1.1**: Proves collaboration value (shared lists)
3. **v1.2+**: Proves business model (monetization)

**Timeline**: 
- v1.0 Launch: 4 weeks from start
- v1.1 Release: 6 weeks from start
- Monetization: After validating product-market fit

---

## v1.0: Accelerated 4-Week MVP Plan

**Goal**: Ship a polished single-user shopping list app to production

**Strategy**: Data layer first (Week 1), then UI (Weeks 2-3), then polish (Week 4)

### Week 1: Data Layer + Auth (Days 1-7)

**Focus**: Build solid foundation - all data repositories and authentication

#### Days 1-2: Shopping Items Repository
- [ ] Create `ShoppingItemRepository` interface in `lib/features/shopping_list/domain/repositories/`
- [ ] Implement `LocalShoppingItemRepository` (Sembast) in `lib/features/shopping_list/data/repositories/`
- [ ] CRUD operations: create, read, update, delete items
- [ ] Query by listId (get all items for a list)
- [ ] Stream-based watching (watchItems, watchItemsByListId)
- [ ] Write unit tests (follow existing repository test patterns)
- [ ] Create Riverpod provider

**Estimated Time**: 8-12 hours

#### Days 3-4: Authentication System
- [ ] Create `UserRepository` interface in `lib/shared/repositories/`
- [ ] Implement `LocalUserRepository` (cache current user in Sembast)
- [ ] Implement `FirebaseUserRepository` (read/write to Firestore `users` collection)
- [ ] Create `AuthService` for Firebase Auth operations
- [ ] Authentication state provider (Riverpod `StreamNotifier` watching auth state)
- [ ] Sign-in with email/password
- [ ] Sign-in with Google
- [ ] Sign-up with email/password
- [ ] Sign-out functionality
- [ ] Write tests for auth flows

**Estimated Time**: 10-14 hours

#### Days 5-6: Cloud Sync (Basic)
- [ ] Create `FirebaseShoppingListRepository` in `lib/core/database/firebase/`
- [ ] Implement Firestore CRUD for shopping lists (save to `shopping_lists` collection)
- [ ] Create `FirebaseShoppingItemRepository`
- [ ] Implement Firestore CRUD for shopping items (save to `shopping_items` collection)
- [ ] Sync strategy: Write to local first, then to Firestore
- [ ] On app start: Load from Firestore, merge with local
- [ ] Simple conflict resolution: Last write wins (compare updatedAt timestamps)
- [ ] Firestore security rules (users can only access their own lists)

**Estimated Time**: 10-14 hours

#### Day 7: Auth UI
- [ ] Create `WelcomeScreen` (first launch, explain app value)
- [ ] Create `SignInScreen` (email/password form, Google sign-in button)
- [ ] Create `SignUpScreen` (email/password/name form)
- [ ] Add loading states for async auth operations
- [ ] Add error handling (show snackbars for auth errors)
- [ ] Navigation: If not authenticated → show SignInScreen, else → show home

**Estimated Time**: 6-8 hours

**✅ Week 1 Milestone:**
- Complete data layer for lists & items
- Authentication fully working (email + Google)
- Basic cloud sync operational
- Ready to build UI

---

### Week 2: Core List UI (Days 8-14)

**Focus**: Build main shopping list screens and basic functionality

#### Days 8-9: Lists Home Screen
- [ ] Create `ListsScreen` in `lib/features/shopping_list/presentation/screens/`
- [ ] Create `ListsNotifier` (Riverpod Notifier) to manage lists state
- [ ] Display all user's lists in grid or list view
- [ ] Show list card with: name, color, item count, progress (X/Y completed)
- [ ] FAB to create new list
- [ ] Pull-to-refresh to reload lists
- [ ] Empty state: "No lists yet" with illustration
- [ ] Loading skeleton while fetching
- [ ] Error state if fetch fails
- [ ] Tap list → navigate to list detail screen

**Estimated Time**: 10-12 hours

#### Days 10-11: Create & Edit Lists
- [ ] Create `CreateEditListDialog` (bottom sheet or full screen)
- [ ] Form fields:
  - List name (required, TextField)
  - Description (optional, TextField)
  - Color picker (grid of color options)
- [ ] Save button: Validate, create/update list, close dialog
- [ ] Cancel button: Discard changes, close dialog
- [ ] Show validation errors (e.g., "Name is required")
- [ ] Archive list functionality (swipe action or menu)
- [ ] Delete list functionality (with confirmation dialog)
- [ ] Show archived lists (toggle or separate tab)
- [ ] Unarchive option for archived lists

**Estimated Time**: 8-10 hours

#### Days 12-14: List Detail & Items (Part 1)
- [ ] Create `ListDetailScreen` showing single list
- [ ] List header:
  - List name, description
  - Color indicator
  - Progress bar (X of Y items checked)
  - Edit/Archive/Delete actions (menu)
- [ ] Items list:
  - Display all items for this list
  - Checkbox to complete/uncomplete item
  - Show item name, quantity, category
  - Completed items at bottom or hidden
- [ ] FAB to add new item
- [ ] Empty state: "No items yet, tap + to add"
- [ ] Create `AddEditItemDialog`:
  - Item name (required, TextField with autocomplete)
  - Quantity (number TextField)
  - Unit (dropdown: pieces, kg, liters, etc.)
  - Category (dropdown: produce, dairy, meat, etc.)
  - Notes (optional, TextField)
  - Save/Cancel buttons

**Estimated Time**: 12-16 hours

**✅ Week 2 Milestone:**
- Users can view all their lists
- Users can create, edit, delete lists
- Users can view items in a list
- Users can add items (basic)
- Core shopping flow working

---

### Week 3: Item Management & Settings (Days 15-21)

**Focus**: Complete item functionality and build settings

#### Days 15-16: Advanced Item Features
- [ ] Edit item (tap item → open AddEditItemDialog in edit mode)
- [ ] Delete item (swipe left → delete, with confirmation)
- [ ] Reorder items (long-press → drag to reorder, update sortOrder)
- [ ] Bulk actions:
  - "Complete all" button
  - "Delete completed" button
  - "Clear all" button (with confirmation)
- [ ] Group by category toggle:
  - Show items grouped by category
  - Show section headers
  - Optional: Collapse/expand categories
- [ ] Item suggestions:
  - Query user's history for frequently used items
  - Show suggestions as chips below input
  - Tap suggestion → auto-fill name/category
- [ ] Quick-add mode:
  - Text field at top of list
  - Type name + Enter → instantly add item
  - Bypass full dialog for speed

**Estimated Time**: 12-14 hours

#### Days 17-18: Settings Screen
- [ ] Create `SettingsScreen` (in settings tab)
- [ ] Profile section:
  - Display user photo, name, email
  - Edit profile button → `EditProfileDialog`
- [ ] Edit profile dialog:
  - Update display name
  - Update photo (image picker, upload to Firebase Storage)
  - Save changes
- [ ] Preferences section:
  - Theme selector: Light / Dark / System (update ThemeNotifier)
  - Language selector: English / French (update localization)
- [ ] Account section:
  - Sign out button (with confirmation)
  - Delete account button (with scary confirmation)
- [ ] About section:
  - App version
  - Licenses
  - Privacy policy link
  - Terms of service link

**Estimated Time**: 8-10 hours

#### Days 19-20: Onboarding & Polish
- [ ] Create `OnboardingScreen` (show once on first launch):
  - Screen 1: "Welcome to Listly"
  - Screen 2: "Create shopping lists"
  - Screen 3: "Shop smarter"
  - Skip button, Next button, Get Started button
- [ ] Add loading states throughout app:
  - Shimmer/skeleton loaders for list items
  - Circular progress indicators during operations
- [ ] Improve error messages:
  - User-friendly messages (not technical errors)
  - Actionable suggestions ("Check your internet connection")
- [ ] Empty states:
  - Illustrations or icons
  - Helpful text
  - Call-to-action buttons
- [ ] Smooth animations:
  - List transitions
  - Dialog animations
  - Fade-ins for images

**Estimated Time**: 8-12 hours

#### Day 21: Accessibility & Localization
- [ ] Ensure ALL strings use `appLocalization.getString()`
- [ ] Add missing French translations for any new strings
- [ ] Test app in French (change device language)
- [ ] Add semantic labels for screen readers:
  - Buttons: "Add new list", "Delete item"
  - Images: Alt text
  - Form fields: Labels
- [ ] Test with TalkBack (Android) and VoiceOver (iOS)
- [ ] Ensure touch targets are ≥48dp
- [ ] Test keyboard navigation
- [ ] Check color contrast ratios (accessibility guidelines)

**Estimated Time**: 6-8 hours

**✅ Week 3 Milestone:**
- Feature-complete v1.0 MVP
- All screens built and functional
- Settings working
- Polished UI
- Accessible and localized

---

### Week 4: Testing, Optimization & Launch (Days 22-28)

**Focus**: Quality assurance, bug fixes, and launch preparation

#### Days 22-23: Testing
- [ ] Write integration tests:
  - Auth flow: Sign up → Sign in → Use app → Sign out
  - List flow: Create list → Add items → Complete items → Delete list
  - Offline mode: Disconnect → Create list → Reconnect → Verify sync
- [ ] Manual testing checklist (iOS):
  - Test on iPhone (small screen)
  - Test on iPad (large screen)
  - Test on iOS 12+ (min version)
  - Test dark mode
  - Test landscape orientation
- [ ] Manual testing checklist (Android):
  - Test on small phone (5" screen)
  - Test on tablet
  - Test on Android 5.0+ (API 21+)
  - Test dark mode
- [ ] Offline testing:
  - Enable airplane mode
  - Create lists/items
  - Disable airplane mode
  - Verify auto-sync
- [ ] Edge cases:
  - No internet on first launch
  - Very long list names
  - 100+ items in a list
  - Special characters in names
  - Rapid-fire actions (stress test)

**Estimated Time**: 12-16 hours

#### Days 24-25: Bug Fixes & Optimization
- [ ] Fix all critical bugs (crashes, data loss)
- [ ] Fix high-priority bugs (broken features)
- [ ] Address medium-priority bugs (annoyances)
- [ ] Performance optimization:
  - App startup time (should be <2 seconds)
  - Screen transitions (should be smooth 60fps)
  - Database queries (add indexes if slow)
  - Image loading (lazy load, cache)
- [ ] Memory optimization:
  - Check for memory leaks
  - Optimize image sizes
  - Dispose controllers properly
- [ ] Battery optimization:
  - Minimize background operations
  - Efficient sync strategy

**Estimated Time**: 12-16 hours

#### Day 26: Beta Testing
- [ ] Build beta versions:
  - iOS: TestFlight build
  - Android: Firebase App Distribution build
- [ ] Invite 5-10 beta testers (friends, family)
- [ ] Provide feedback form (Google Forms or similar)
- [ ] Ask testers to focus on:
  - Crashes or bugs
  - Confusing UI
  - Missing features
  - Performance issues
- [ ] Monitor Crashlytics for errors
- [ ] Collect and prioritize feedback
- [ ] Fix any showstopper bugs

**Estimated Time**: 6-8 hours

#### Day 27: Final Polish
- [ ] Fix all beta feedback issues
- [ ] Final UI pass:
  - Consistent spacing
  - Consistent colors
  - Consistent typography
  - Aligned elements
- [ ] Test on multiple screen sizes again
- [ ] Ensure all animations are smooth
- [ ] Check all text for typos
- [ ] Verify all translations
- [ ] Test both themes (light/dark)
- [ ] Final accessibility check

**Estimated Time**: 6-8 hours

#### Day 28: Launch Preparation
- [ ] **App Store (iOS)**:
  - Create app listing in App Store Connect
  - Take screenshots (required sizes, both iPhone and iPad if supporting)
  - Write app description (compelling, clear value prop)
  - Add keywords for ASO
  - Set pricing (free)
  - Create privacy policy (host on website or GitHub Pages)
  - Submit for review
- [ ] **Google Play (Android)**:
  - Create app listing in Play Console
  - Take screenshots (phone, tablet, both themes)
  - Write app description
  - Add app icon (512x512)
  - Create feature graphic
  - Set content rating
  - Privacy policy URL
  - Submit for review
- [ ] **Marketing Prep**:
  - Create landing page (optional, can use App Store/Play Store links)
  - Prepare social media posts
  - Draft launch email (if you have a list)
  - Product Hunt submission (optional)
- [ ] **Support Setup**:
  - Create support email (support@listly.app or similar)
  - Set up email forwarding
  - Prepare FAQ document

**Estimated Time**: 6-10 hours

**✅ Week 4 Milestone:**
- Production-ready v1.0
- Submitted to App Store & Play Store
- Beta tested and polished
- Ready for public launch

---

## v1.1: Collaboration Update (Weeks 5-6, Post-Launch)

**Goal**: Add sharing and real-time collaboration while v1.0 is in review

**Timeline**: Start during Week 4, release 1-2 weeks after v1.0 launch

### Week 5: Sharing Implementation (Days 29-35)

**Focus**: Enable list sharing with other users

#### Days 29-30: Share List Feature
- [ ] Update `ShoppingList` model to support participantIds (already exists)
- [ ] Create `ShareListDialog`:
  - Input field for email or user ID
  - "Add participant" button
  - List of current participants
  - Remove participant button (creator only)
- [ ] Implement `addParticipant()` in repository:
  - Validate user exists in Firebase
  - Add userId to participantIds
  - Update Firestore
- [ ] Implement `removeParticipant()` in repository
- [ ] Show "Share" button on list detail screen
- [ ] Permission checks:
  - Only creator can add/remove participants
  - Check `ListPermissions.anyoneCanInvite` setting (future)

**Estimated Time**: 10-12 hours

#### Days 31-32: Firestore Security Rules & Queries
- [ ] Update Firestore security rules:
  - Users can read lists where they're creator OR participant
  - Users can write lists where they're creator (or have permission)
  - Users can read/write items in lists they can access
- [ ] Update `FirebaseShoppingListRepository` queries:
  - Fetch lists where user is creator OR participant
  - Use Firestore `array-contains` for participantIds
- [ ] Test sharing with multiple accounts:
  - Create list as User A
  - Share with User B
  - Verify User B can see list
  - Verify User B can add items

**Estimated Time**: 8-10 hours

#### Days 33-35: Real-Time Collaboration
- [ ] Implement Firestore listeners in repositories:
  - Listen to changes on shared lists
  - Listen to changes on items in shared lists
- [ ] Update UI to show real-time changes:
  - When another user adds an item → auto-update list
  - When another user checks an item → auto-update UI
  - When list is renamed → update header
- [ ] Handle conflicts gracefully:
  - If two users edit same item simultaneously → last write wins
  - Show optimistic updates (update UI immediately, sync in background)
- [ ] Show activity indicators (optional):
  - "John added milk"
  - "Sarah completed eggs"
  - Timestamp of last activity

**Estimated Time**: 12-16 hours

**✅ Week 5 Milestone:**
- List sharing working
- Real-time collaboration functional
- Multiple users can edit same list simultaneously

---

### Week 6: Notifications & Polish (Days 36-42)

**Focus**: Add push notifications and fix bugs from v1.0 launch

#### Days 36-37: Push Notifications
- [ ] Firebase Cloud Messaging (FCM) setup:
  - Already integrated in project
  - Request notification permissions on app start
- [ ] Implement Cloud Functions (optional backend):
  - Function: `onListShared` → send notification when added to list
  - Function: `onItemAdded` → send notification when item added to shared list (optional)
- [ ] Or use Firestore triggers with FCM tokens:
  - Store FCM token in user document
  - Query tokens for all participants
  - Send notification via Firebase Admin SDK
- [ ] Notification handling in app:
  - Tap notification → navigate to shared list
  - Show notification even when app is closed
- [ ] Notification settings:
  - Toggle notifications on/off in Settings
  - Granular controls (list shared, item added, item completed)

**Estimated Time**: 12-16 hours

#### Days 38-40: v1.0 Bug Fixes
- [ ] Review v1.0 user feedback (reviews, support emails)
- [ ] Fix critical bugs reported by users
- [ ] Fix high-priority issues
- [ ] Performance improvements based on crash reports
- [ ] UI/UX tweaks based on feedback:
  - Confusing interactions
  - Hard-to-find features
  - Visual improvements
- [ ] Update localization if needed
- [ ] Test all fixes thoroughly

**Estimated Time**: 12-18 hours

#### Days 41-42: v1.1 Testing & Release
- [ ] Integration tests for sharing:
  - Share list → verify participant can access
  - Add item as participant → verify creator sees it
  - Remove participant → verify they lose access
- [ ] Manual testing with 2+ devices:
  - Test real-time sync
  - Test notifications
  - Test offline/online scenarios with sharing
- [ ] Beta test with small group (v1.1 early access)
- [ ] Fix any final bugs
- [ ] Update App Store/Play Store listings:
  - Add "Share lists" to feature list
  - New screenshots showing collaboration
  - Update version number (1.1.0)
- [ ] Submit v1.1 update for review
- [ ] Prepare release notes highlighting new features

**Estimated Time**: 8-12 hours

**✅ Week 6 Milestone:**
- v1.1 released with sharing & notifications
- v1.0 bugs fixed
- Real-time collaboration validated with users
- Ready for growth phase

---

## v1.2+ Future Development

**After v1.1 ships**, assess user feedback and decide on next priorities. Refer to the monetization strategy in AI_DEVELOPMENT_GUIDE.md for Phase 2 (ads/IAP) and Phase 3 (AI features) details.

### Potential v1.2+ Features (Prioritize Based on Feedback)

**📊 Feature Categories to Consider:**

1. **Monetization (v1.2)**
   - AdMob integration (banner + interstitial ads)
   - In-app purchases (subscriptions: $2.99/mo, $24.99/yr, $49.99 lifetime)
   - Feature gating (10 lists free, unlimited premium)
   - 7-day free trial
   - See: AI_DEVELOPMENT_GUIDE.md - Monetization Strategy (Phase 2)

2. **AI Features (v1.3)**
   - Basic AI suggestions (5 per week for free users)
   - Advanced AI (unlimited smart suggestions for premium)
   - Smart categorization (auto-categorize items)
   - Smart list building ("Create list for taco night")
   - Natural language input
   - See: AI_DEVELOPMENT_GUIDE.md - AI Feature Strategy (Phase 3)

3. **Analytics & Insights (v1.4)**
   - Shopping analytics dashboard (premium)
   - Most bought items tracking
   - Shopping frequency patterns
   - Spending predictions
   - Budget alerts

4. **Advanced Collaboration (v1.5)**
   - QR code sharing
   - Public shareable links with expiration
   - Role-based permissions (Owner, Editor, Viewer)
   - Activity feed ("John added milk 2 min ago")
   - Real-time presence indicators

5. **Smart Features (v1.6)**
   - Item photos (premium)
   - Export to CSV/PDF (premium)
   - List templates (pre-built + custom)
   - Duplicate detection
   - Smart quantity merging
   - Location-based reminders (premium)

6. **Advanced Features (v2.0+)**
   - Voice input and commands
   - Recipe integration
   - Price tracking
   - Smart home integration (Alexa, Google Home)
   - Family plans
   - Rewarded video ads (if needed)

**Decision Making**: After v1.1, gather user feedback to decide:
- Should we monetize first (v1.2) or add more features?
- What features do users request most?
- What features drive the most engagement?
- Is there product-market fit for premium tier?

**Refer to AI_DEVELOPMENT_GUIDE.md for detailed roadmaps** on Phase 2 (Monetization) and Phase 3 (AI Features).

---

## Technical Infrastructure

### Critical Infrastructure (Build as Needed)

**Sync Service** (v1.0):
- [x] Local-only (Sembast) - Already implemented
- [ ] Basic Firebase sync (Week 1, Days 5-6)
- [ ] Simple conflict resolution (last write wins)
- Future: Advanced sync with CRDTs (v1.2+)

**Testing** (Throughout v1.0):
- [ ] Unit tests for all services and repositories
- [ ] Widget tests for all screens
- [ ] Integration tests for critical flows (Week 4, Days 22-23)
- [ ] Manual QA on iOS & Android (Week 4)

**CI/CD** (Optional for v1.0, recommended for v1.1+):
- [ ] GitHub Actions for automated testing
- [ ] Automated builds for iOS & Android
- [ ] TestFlight / Firebase App Distribution setup

**Monitoring** (v1.0):
- [x] Crashlytics already integrated
- [ ] Firebase Performance Monitoring (enable in Firebase console)
- [ ] Basic analytics for user behavior

---

## Success Metrics

### v1.0 Launch Success Criteria

**Before Public Launch**:
- [ ] Zero critical bugs (crashes, data loss)
- [ ] <5 high-priority bugs
- [ ] 5-10 beta testers with positive feedback
- [ ] 4.5+ average beta rating
- [ ] App startup <2 seconds
- [ ] 60fps screen transitions

**First Month After Launch**:
- [ ] 100+ installs
- [ ] <10% uninstall rate
- [ ] 4.0+ App Store/Play Store rating
- [ ] <1% crash rate
- [ ] User reviews mention "easy to use" or "simple"

### v1.1 Success Criteria

**Feature Adoption**:
- [ ] 30%+ of users share at least 1 list
- [ ] Shared lists have 2+ active participants
- [ ] Real-time sync working without complaints

**Quality**:
- [ ] No sync-related bugs
- [ ] Notifications working reliably
- [ ] Maintain or improve app rating from v1.0

---

## Resource Requirements

### Development (v1.0 & v1.1)

**Human Resources**:
- 1 Full-stack Flutter developer (you!) - Full-time, 4-6 weeks
- AI assistant (me!) for code generation and guidance
- Optional: Designer friend for icon/screenshots review

**Time Investment**:
- Week 1-4: 40-50 hours/week (v1.0 development)
- Week 5-6: 30-40 hours/week (v1.1 development)
- Total: ~220-300 hours for v1.0 + v1.1

### External Services Costs

**v1.0 & v1.1** (Minimal costs):
- Firebase: Free tier (sufficient for <1,000 active users)
- App Store Developer Account: $99/year (one-time for iOS)
- Google Play Developer Account: $25 one-time (Android)
- Domain (optional): ~$12/year for privacy policy hosting
- **Total upfront cost**: ~$136

**After Launch** (Scaling costs):
- Firebase: $0-25/month (grows with users, but very affordable early on)
- Cloud Functions (for notifications): Included in Firebase free tier initially
- **Estimated monthly: $0-25** for first 1,000 users

---

## Risk Mitigation

### v1.0 & v1.1 Specific Risks

**Risk**: Scope creep during development
- **Mitigation**: Strict adherence to version definitions; defer everything not in v1.0/v1.1
- **Red flag**: "This will only take an hour" - it never does!

**Risk**: Sync bugs causing data loss
- **Mitigation**: Always write to local first, sync to cloud in background
- **Mitigation**: Extensive offline testing, never delete local data without user confirmation

**Risk**: App Store/Play Store rejection
- **Mitigation**: Follow platform guidelines strictly
- **Mitigation**: Have privacy policy ready before submission
- **Mitigation**: Clear, honest app description

**Risk**: Firebase costs unexpectedly high
- **Mitigation**: Monitor Firebase usage dashboard weekly
- **Mitigation**: Implement Firestore query limits
- **Mitigation**: Firebase free tier is generous; shouldn't be an issue until 1,000+ users

**Risk**: Burnout from 4-6 week sprint
- **Mitigation**: Take breaks, don't work weekends if possible
- **Mitigation**: 4 weeks is aggressive but achievable with AI assistance
- **Mitigation**: Remember: done is better than perfect

**Risk**: No users after launch
- **Mitigation**: Share with friends/family first
- **Mitigation**: Post on Product Hunt, Reddit (r/sideproject), Twitter
- **Mitigation**: Focus on v1.1 first, worry about growth after you have a great product

---

## Next Steps to Begin Development

### Immediate Actions (Today/Tomorrow)

1. ✅ **Review and approve this plan**
2. [ ] **Set up project management**:
   - Create GitHub Issues for Week 1 tasks
   - Or use simple checklist (this document)
   - Or use Notion/Trello for task tracking
3. [ ] **Prepare development environment**:
   - Ensure Flutter SDK up to date
   - Firebase project configured (already done)
   - iOS/Android emulators/devices ready
4. [ ] **Start Week 1, Day 1: Shopping Items Repository**
   - First task is creating ShoppingItemRepository interface
   - Should take 2-4 hours with AI assistance

### Daily Workflow

**Each Morning**:
1. Review today's tasks from the plan
2. Start with highest priority (usually data layer before UI)
3. Code → Test → Commit frequently

**With AI Assistant**:
1. "Build [feature] according to plan"
2. Review generated code
3. Test on device
4. Provide feedback for iteration
5. Move to next task

**Each Evening**:
1. Commit all work
2. Update plan with progress notes
3. Prepare tomorrow's tasks

---

## Appendix: Dependencies to Add

### v1.0 (Week 1-4)
```yaml
# Already have most dependencies
# May need to add:
google_sign_in: ^6.1.5        # Google authentication (Day 3-4)
cached_network_image: ^3.3.0  # User profile photos (Day 17-18)
image_picker: ^1.0.5          # Profile photo picker (Day 17-18)
```

### v1.1 (Week 5-6)
```yaml
# No new dependencies likely needed
# FCM already integrated (firebase_messaging)
```

### v1.2+ (Future)
```yaml
google_mobile_ads: ^5.0.0     # AdMob integration
in_app_purchase: ^3.1.11      # IAP (or consider RevenueCat SDK)
http: ^1.1.0                  # AI API calls
file_picker: ^6.1.1           # CSV export
# More TBD based on feature decisions
```

---

**Document Status**: ✅ Ready - Accelerated 4-Week Plan  
**Next Update**: Daily progress notes during development  
**Start Date**: [Fill in when you start]  
**Target Launch**: [Start Date + 4 weeks]
