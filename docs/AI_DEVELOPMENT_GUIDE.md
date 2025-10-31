# Listly - AI Development Guide

This document provides comprehensive context, goals, specifications, and guidelines for AI assistants developing the Listly application. Read this document fully before making any code contributions.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Goals & Vision](#goals--vision)
3. [Monetization Strategy](#monetization-strategy)
4. [Technical Specifications](#technical-specifications)
5. [Architecture Deep Dive](#architecture-deep-dive)
6. [Development Workflow](#development-workflow)
7. [AI-Specific Guidelines](#ai-specific-guidelines)
8. [Common Tasks & Patterns](#common-tasks--patterns)

---

## Project Overview

**Listly** is a collaborative, offline-first grocery shopping list application built with Flutter. The app allows users to create, manage, and share shopping lists in real-time with family, friends, or roommates.

### Core Value Propositions

1. **Offline-First Architecture**: Users can create and modify lists without internet connectivity. Changes sync automatically when online.
2. **Real-Time Collaboration**: Multiple users can edit the same list simultaneously with instant updates.
3. **Flexible Sharing**: Share lists via direct invitation, shareable links, or QR codes.
4. **Mobile-Focused**: Native experience on iOS and Android devices for on-the-go shopping.
5. **Privacy-Focused**: User data is stored locally first, with optional cloud sync.

### Business Model

**Freemium with Ad-Supported Free Tier**:
- **Free Users**: Full functionality with non-intrusive advertisements
- **Premium Users**: Ad-free experience with subscription
- Monetization strategy details to be finalized

### Current Status

- **Version**: 0.1.0 (Early Development)
- **Stability**: Core infrastructure in place; features under active development
- **Testing**: Unit and widget tests established; golden tests for theme components
- **Target Platforms**: iOS and Android (mobile-first approach)

---

## Goals & Vision

### Short-Term Goals (Current Phase)

1. **Complete Core Features**:
   - Shopping list CRUD operations (local & cloud)
   - Shopping item management
   - Basic user authentication
   - List sharing via participant invitation

2. **Establish Solid Foundation**:
   - Robust offline-first synchronization
   - Comprehensive test coverage
   - Performance optimization for large lists
   - Error handling and recovery

3. **Polish User Experience**:
   - Intuitive UI/UX following Material Design 3
   - Smooth animations and transitions
   - Accessibility compliance (WCAG 2.1 AA)
   - Multi-language support (English, French, expandable)

### Mid-Term Goals

1. **Advanced Collaboration**:
   - Real-time presence indicators
   - Change history and undo/redo
   - Conflict resolution UI
   - Role-based permissions (viewer, editor, admin)

2. **Smart Features**:
   - Item suggestions based on history
   - Category organization
   - Price tracking and budget alerts
   - Recipe integration

3. **Enhanced Sharing**:
   - QR code generation and scanning
   - Public link sharing with expiration
   - Family/household group management

### Long-Term Vision

- AI-powered shopping assistance (meal planning, automatic categorization)
- Advanced voice input and accessibility features
- Smart home integration (Alexa, Google Home)
- Community features (shared recipe lists, household management)
- Advanced analytics and insights (spending patterns, shopping habits)

---

## Monetization Strategy

Listly employs a **Hybrid Freemium Model** that balances user value with sustainable revenue generation. The strategy focuses on providing full core functionality to free users while offering compelling premium features that justify subscription costs.

### Business Model Overview

**Freemium with Ad-Supported Free Tier + AI-Powered Premium**

- **Free Users**: Access to all core shopping features with conservative, non-intrusive advertisements
- **Premium Users**: Ad-free experience with unlimited access, advanced AI features, and analytics
- **Revenue Streams**: In-app subscriptions (primary), ad revenue (secondary)

### Pricing Structure

| Plan | Price | Billing | Target User |
|------|-------|---------|-------------|
| **Monthly** | $2.99/month | Monthly | Trial users, casual shoppers |
| **Annual** | $24.99/year | Yearly | Regular users (30% savings) |
| **Lifetime** | $49.99 | One-time | Power users, gift purchases |

**Trial Period**: 7-day free trial for all premium features (no credit card required during trial)

**Future**: Family Plan at $34.99/year for up to 5 accounts (Phase 3+)

### Free vs Premium Feature Comparison

#### ✅ FREE TIER - Core Shopping Experience

**Shopping Features:**
- Up to 10 shopping lists
- Unlimited items per list
- Share lists with up to 5 participants per list
- Real-time collaboration on shared lists
- Offline-first functionality with automatic sync
- Check/uncheck items
- Basic item notes and quantities

**Organization:**
- Pre-defined categories (Produce, Dairy, Meat, Pantry, etc.)
- Light and dark themes
- List sorting (alphabetical, custom order)

**AI Features (Limited):**
- 5 AI-powered item suggestions per week
- Basic pattern matching from personal history
- Simple auto-complete

**User Experience:**
- Multi-language support (English, French)
- Basic accessibility features
- Community support

**Advertisements:**
- Small banner ad at bottom of list screens
- Occasional interstitial ads after specific actions (see Ad Strategy below)

#### ✨ PREMIUM TIER - Enhanced Experience

**Everything in Free, PLUS:**

**Unlimited Access:**
- Unlimited shopping lists
- Unlimited participants per shared list
- No feature restrictions

**Advanced AI Features:**
- Unlimited AI-powered smart suggestions
- Advanced pattern recognition and predictive shopping
- Smart auto-categorization (AI organizes items automatically)
- Smart list building ("Create a list for pasta dinner")
- Natural language input ("Add 2 pounds chicken and vegetables")
- Intelligent duplicate detection and merging
- Seasonal and recipe-based suggestions

**Customization:**
- Custom list colors and themes
- Custom categories (create your own organization system)
- Custom color schemes
- Personalized UI preferences

**Analytics & Insights:**
- Shopping frequency analysis
- Most purchased items tracking
- Shopping pattern insights
- Spending predictions (future)
- Budget alerts and recommendations (future)

**Data Management:**
- Export lists to CSV format
- PDF export and print-friendly formatting (future)
- Automatic backup and restore
- Data portability

**Media:**
- Attach photos to items
- Visual item recognition
- Image-based categorization

**Experience:**
- Completely ad-free
- Priority sync (instant vs. background)
- Priority customer support
- Early access to new features

**Future Premium Features:**
- Location-based shopping reminders
- Recipe integration and parsing
- Price tracking and comparison
- Voice shopping with AI assistant
- Smart home integration

### Advertisement Strategy

Listly uses a **conservative, user-friendly ad approach** that minimizes disruption while generating revenue from free users.

#### Ad Implementation

**1. Banner Ads** (Persistent, Minimal)
```
Placement: Bottom of list view screens
Size: Adaptive banner (320x50 or similar)
Behavior:
  - Fixed position, doesn't cover content
  - Refresh rate: Maximum 60 seconds
  - Hidden when keyboard is open
  - Respects safe areas on all devices
```

**2. Interstitial Ads** (Action-Based, Conservative)
```
Triggers (maximum 1 per session):
  - After completing a shopping list (all items checked)
  - After archiving a list
  
Rate Limits:
  - Maximum 1 interstitial per app session
  - Minimum 10 minutes between ads if user reopens app
  - Skip if user is exploring premium features
  - Never show during active shopping

Frequency Goal: No more than 1-2 interstitials per day per user
```

**3. Rewarded Video Ads** (Optional, Phase 3+)
```
Implementation: User-initiated only
Availability: 2 per day maximum
Cooldown: 8 hours between rewards
Duration: 24-hour feature unlock

Unlockable Features:
  - Try custom themes for 24 hours
  - Unlock basic analytics for a day
  - Export one list to CSV
  - Preview one premium AI feature

Strategy:
  - First use: Prompt 7-day premium trial
  - Second use: "Last free unlock today"
  - Limit reached: "Get unlimited with Premium"
  
Purpose: 
  - Demo premium value
  - Drive trial conversions
  - Provide escape valve for non-paying users
  
Note: Will NOT be included at launch. Add 3-6 months post-launch if premium conversion rates are below target (10%).
```

#### Ad Platform

**Primary**: Google AdMob
- Best Flutter integration
- Reliable fill rates
- Easy implementation
- Strong documentation

**Future**: Consider mediation platform (AppLovin MAX) to maximize eCPM if revenue goals aren't met.

### AI Feature Strategy

AI-powered features serve as the **primary premium differentiator** beyond ad removal. This strategy justifies premium pricing while providing tangible value.

#### Free Tier: AI Taste

**5 AI Suggestions Per Week** (Resets Monday)
- On-device machine learning
- Pattern matching from user's shopping history
- Simple predictions: "You often buy milk on Mondays"
- Basic auto-complete from personal history
- No API costs

**Purpose**: 
- Demonstrate AI value
- Create desire for unlimited access
- Zero incremental cost

#### Premium Tier: Advanced AI

**Unlimited AI Features** (Cloud-Powered)
- Advanced natural language processing
- Contextual understanding: "Create list for taco night"
- Smart categorization using LLM
- Recipe parsing and list generation
- Duplicate detection with intelligent merging
- Seasonal and trend-based suggestions
- Learning user preferences over time

**Technical Implementation**:
```
Hybrid Approach:
  Free Users:
    - On-device ML (TensorFlow Lite / Core ML)
    - Local pattern matching
    - No API calls
    
  Premium Users:
    - Cloud AI (OpenAI / Google Gemini / Anthropic)
    - Advanced NLP capabilities
    - API costs: ~$0.10-0.50/user/month
    - Covered by premium subscription revenue
```

**Why This Works**:
- Clear value differentiation
- API costs justify premium pricing
- Free users can't abuse expensive AI features
- Premium users get genuinely "smart" shopping assistant
- Competitive moat (hard to replicate)

### Implementation Roadmap

#### **Phase 1: MVP Launch** (Month 0 - Launch Ready)

**Goal**: Establish monetization foundation, validate product-market fit

**Free Tier**:
- Core shopping functionality
- 10 list limit, 5 participants per list
- Conservative banner + interstitial ads
- No AI features yet

**Premium Tier** ($2.99/mo, $24.99/yr, $49.99 lifetime):
- ✅ Ad-free experience
- ✅ Unlimited lists and participants
- ✅ Custom list colors
- ✅ Custom categories
- ✅ Basic CSV export
- 🎁 7-day free trial

**Ad Integration**:
- Google AdMob SDK
- Banner ads on list screens
- Interstitial after list completion/archiving (max 1 per session)

**In-App Purchases**:
- RevenueCat or native IAP implementation
- Subscription management
- Trial period handling
- Restore purchases functionality

**Timeline**: 4-6 weeks of focused development  
**Success Metrics**: 
- 5-10% premium conversion rate
- <30% ad-driven uninstalls
- User feedback on ad frequency

---

#### **Phase 2: AI Introduction** (Month 2-3 Post-Launch)

**Goal**: Differentiate premium with AI, increase perceived value

**Free Tier Adds**:
- ✅ 5 AI suggestions per week (basic, on-device)
- Weekly reset on Mondays
- In-app prompt: "Upgrade for unlimited AI"

**Premium Tier Adds**:
- ✅ Unlimited AI smart suggestions (cloud-powered)
- ✅ Smart auto-categorization
- ✅ Shopping analytics dashboard
  - Most bought items
  - Shopping frequency
  - Item history and patterns
- ✅ Item photos (Firebase Storage)

**Technical Implementation**:
- On-device ML model for free tier
- Cloud AI API integration for premium
- Analytics data aggregation
- Photo upload and storage

**Timeline**: 6-8 weeks of development  
**Success Metrics**:
- Increased premium conversion (target 10-15%)
- AI feature usage rates
- User satisfaction with suggestions

---

#### **Phase 3: Advanced AI & Optimization** (Month 4-6 Post-Launch)

**Goal**: Build competitive moat, optimize monetization

**Premium Tier Adds**:
- ✅ Smart list building ("Create list for [meal/event]")
- ✅ Natural language input
- ✅ Intelligent duplicate detection
- ✅ Advanced analytics with predictions
- ✅ PDF export and print-friendly views

**Free Tier Adds**:
- ✅ Rewarded video ads (2 per day max)
  - 24-hour premium feature unlocks
  - Drive trial conversions
  - Provide value without full premium

**Ad Optimization**:
- Analyze ad performance and user behavior
- A/B test ad placements and frequency
- Optimize for revenue without degrading UX
- Consider ad mediation if needed

**Timeline**: Ongoing feature development (2-3 months)  
**Success Metrics**:
- Premium conversion rate >15%
- LTV/CAC ratio >3:1
- Rewarded ad engagement rates

---

#### **Phase 4: Future Enhancements** (Month 6+ Post-Launch)

**Goal**: Long-term retention and expansion

**Features**:
- ✅ Location-based shopping reminders
- ✅ Recipe integration and parsing
- ✅ Price tracking and spending insights
- ✅ Voice shopping with AI assistant
- ✅ Smart home integration (Alexa, Google Home)
- ✅ Family plan subscriptions ($34.99/year)
- ✅ Gift subscriptions

**Optimization**:
- Continuous AI model improvements
- Personalization engine enhancements
- Performance optimization
- Platform-specific features

**Timeline**: Ongoing  
**Success Metrics**:
- Retention rate >40% at 6 months
- Premium LTV >$50
- Net revenue growth

### Economic Model

Understanding the unit economics ensures sustainable growth:

#### Cost Structure (Per Active User Per Month)

**Free User Costs**:
```
Firebase Auth:           Free
Firestore Operations:    ~$0.01
Firebase Hosting:        Negligible
AI (on-device only):     Free
Ad Revenue (estimated):  $0.10-0.30
-------------------------------------
Net Cost/Revenue:        +$0.09-0.29 per user
```

**Premium User Costs**:
```
Firebase Auth:           Free
Firestore Operations:    ~$0.02 (higher usage)
Firebase Storage:        ~$0.05 (photos)
AI API Calls:            ~$0.10-0.50
-------------------------------------
Total Cost:              ~$0.17-0.57 per user
```

**Premium User Revenue**:
```
Monthly Plan:            $2.99
Annual Plan (monthly):   $2.08
Lifetime (amortized):    $0.50-1.00/month (over 5 years)
-------------------------------------
Weighted Average:        ~$2.50/month
```

**Profit Margins**:
```
Monthly Subscriber Profit:     $2.42-2.82 (81-94% margin)
Annual Subscriber Profit:      $1.51-1.91 (73-92% margin)
```

#### Break-Even Analysis

**Assumptions**:
- 10,000 monthly active users
- 10% premium conversion rate
- 90% free users with ads

**Scenario**:
```
Free Users:    9,000 users × $0.20 net revenue  = $1,800
Premium Users: 1,000 users × $2.50 profit       = $2,500
-------------------------------------
Monthly Net Revenue:                            = $4,300
Annual Run Rate:                                = $51,600
```

**Target Metrics for Profitability**:
- Premium conversion rate: >10%
- Monthly churn: <5%
- LTV/CAC ratio: >3:1
- Break-even at ~5,000 MAU with 10% conversion

### Monetization Guidelines for Development

When building features, always consider:

1. **Feature Classification**
   - Is this core functionality? → Free tier
   - Does this cost money (API calls, storage)? → Premium
   - Is this a "nice-to-have" enhancement? → Premium
   - Would paywalling this frustrate users? → Free tier

2. **Ad Placement Decisions**
   - Never interrupt active shopping
   - Only after natural break points
   - Respect user's task completion
   - Always provide value before showing ads

3. **AI Feature Gating**
   - Free tier: Demonstration value only
   - Premium tier: Unlimited, high-quality AI
   - Track API costs per user
   - Optimize prompts for cost efficiency

4. **Premium Conversion Opportunities**
   - Show premium features in-app (locked)
   - Clear "Upgrade" prompts at natural points
   - Highlight specific premium benefits
   - Make trial activation frictionless

5. **User Experience Priority**
   - Free users should feel valued, not punished
   - Ads should be conservative and respectful
   - Premium should feel premium (instant, polished)
   - Never degrade free tier to push premium

### Metrics to Track

**Acquisition**:
- Daily/Monthly Active Users (DAU/MAU)
- Install sources and conversion rates
- Cost per install (CPI)

**Engagement**:
- Lists created per user
- Items added per session
- Sharing frequency
- Feature usage rates (especially AI)

**Monetization**:
- Free to premium conversion rate (target >10%)
- Trial to paid conversion rate (target >30%)
- Average revenue per user (ARPU)
- Lifetime value (LTV)
- Churn rate (target <5% monthly)

**Ad Performance**:
- Ad impressions per user
- eCPM (effective cost per mille)
- Ad-driven uninstalls or complaints
- Banner vs. interstitial performance

**Premium Retention**:
- Monthly retention curves
- Cohort analysis
- Cancellation reasons
- Feature usage by premium users

### Future Considerations

**Potential Expansions**:
- B2B tier for restaurants, caterers (bulk list management)
- White-label licensing for grocery stores
- Affiliate revenue from grocery delivery services
- Premium templates marketplace (user-generated)

**Risk Mitigation**:
- Don't over-rely on ads (focus on premium conversions)
- Monitor AI API costs closely (implement rate limiting if needed)
- Test pricing elasticity (may be able to charge more)
- Consider regional pricing for international markets

**Competitive Positioning**:
- Most competitors are fully free (OurGroceries) or fully paid (AnyList)
- Hybrid model provides best of both worlds
- AI features provide unique competitive advantage
- Focus on quality over feature quantity

---

## Technical Specifications

### Technology Stack

| Layer | Technology | Version | Purpose |
|-------|-----------|---------|---------|
| **Frontend** | Flutter | SDK ^3.8.1 | Mobile UI framework (iOS & Android) |
| **State Management** | Riverpod | ^3.0.0 | Reactive state & dependency injection |
| **Local Database** | Sembast | ^3.8.5 | NoSQL offline storage |
| **Cloud Backend** | Firebase | Various | Authentication, Firestore, Messaging, Crashlytics |
| **Navigation** | GoRouter | ^16.2.4 | Declarative routing |
| **Data Classes** | Freezed | ^3.1.0 | Immutable models with code generation |
| **Localization** | flutter_localization | ^0.3.3 | i18n support |
| **Monetization** | TBD | TBD | Ad integration for free tier |

### Key Dependencies

```yaml
# Core Dependencies
- firebase_auth: ^6.0.2          # User authentication
- cloud_firestore: ^6.0.1        # Cloud database
- firebase_messaging: ^16.0.1    # Push notifications
- firebase_crashlytics: ^5.0.1   # Error tracking
- sembast: ^3.8.5+1               # Local NoSQL database
- flutter_riverpod: ^3.0.0       # State management
- go_router: ^16.2.4              # Navigation
- freezed: ^3.1.0                 # Immutable data classes
- uuid: ^4.4.0                    # Unique ID generation

# Development Dependencies
- build_runner: ^2.5.4            # Code generation
- mockito: ^5.4.4                 # Testing mocks
- riverpod_generator: ^3.0.0     # Riverpod code generation
- riverpod_lint: ^3.0.0          # Riverpod linting rules
- lint: ^2.8.0                    # Strict Dart linting
```

### Platform Support

| Platform | Status | Min Version | Notes |
|----------|--------|-------------|-------|
| Android | ✅ Supported | API 21+ (Android 5.0) | Google Play Services required |
| iOS | ✅ Supported | iOS 12+ | App Store ready |
| Web | ❌ Not Planned | - | Mobile-first approach |
| macOS | ❌ Not Planned | - | Mobile-first approach |
| Linux | ❌ Not Planned | - | Mobile-first approach |
| Windows | ❌ Not Planned | - | Mobile-first approach |

**Note**: While Flutter supports multiple platforms, Listly is designed as a mobile-first application optimized for on-the-go grocery shopping.

---

## Architecture Deep Dive

### Architectural Patterns

Listly follows **Clean Architecture** principles with **Feature-First** organization:

```
lib/
├── app/                    # Application-level concerns
│   ├── navigation/        # App routing and navigation
│   └── theme/             # Design system and theming
├── core/                   # Cross-cutting infrastructure
│   └── database/          # Database initialization & config
├── features/               # Feature modules (domain-driven)
│   └── shopping_list/
│       ├── domain/        # Business logic & entities
│       ├── data/          # Data sources & repositories
│       └── presentation/  # UI & state management
└── shared/                 # Reusable utilities
    ├── localization/      # i18n translations
    ├── models/            # Shared domain models
    ├── providers/         # Global Riverpod providers
    └── repositories/      # Repository abstractions
```

### Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│                         PRESENTATION                         │
│  (ConsumerWidget, Notifier, UI State)                       │
└──────────────────┬──────────────────────────────────────────┘
                   │ ref.watch/ref.read
                   ▼
┌─────────────────────────────────────────────────────────────┐
│                    RIVERPOD PROVIDERS                        │
│  (Dependency Injection, State Management)                   │
└──────────────────┬──────────────────────────────────────────┘
                   │ repository.getAll() / .create()
                   ▼
┌─────────────────────────────────────────────────────────────┐
│                      REPOSITORY                              │
│  (Business Logic, Coordination)                             │
└──────────────┬─────────────────────┬────────────────────────┘
               │                     │
   Local First │                     │ Background Sync
               ▼                     ▼
┌──────────────────────┐   ┌────────────────────────┐
│   SEMBAST (Local)    │   │  FIRESTORE (Cloud)     │
│  Offline-First DB    │   │  Real-time Sync        │
└──────────────────────┘   └────────────────────────┘
```

### Core Architectural Principles

1. **Offline-First Strategy**:
   - All write operations hit local Sembast database first
   - Background sync process pushes changes to Firestore
   - Conflict resolution favors "last write wins" with timestamps
   - UI never blocks waiting for network operations

2. **Repository Pattern**:
   - All data access goes through repository abstractions
   - Repositories implement `BaseRepository<T, ID>` interface
   - Repositories hide data source details (Sembast vs Firestore)
   - Repositories provide both Future-based and Stream-based APIs

3. **Dependency Injection via Riverpod**:
   - All dependencies injected through Riverpod providers
   - No global singletons or service locators
   - Providers declared near their consumers for clarity
   - Easy mocking for testing via provider overrides

4. **Immutable State**:
   - All models use Freezed for immutability
   - State changes create new objects via `copyWith()`
   - No direct field mutation
   - Predictable state transitions

### Key Domain Models

#### ShoppingList
```dart
ShoppingList(
  id: String,                    // UUID
  creatorUserId: String,         // Creator's Firebase UID
  participantIds: List<String>,  // Shared user UIDs
  name: String,                  // Display name
  description: String?,          // Optional description
  color: String?,                // Hex color code
  itemIds: List<String>,         // References to ShoppingItem IDs
  createdAt: DateTime,
  updatedAt: DateTime,
  lastActivityAt: DateTime,
  isArchived: bool,
  permissions: ListPermissions,
)
```

#### ShoppingItem
```dart
ShoppingItem(
  id: String,
  listId: String,          // Parent list reference
  name: String,
  quantity: String?,
  category: String?,
  isChecked: bool,
  addedBy: String?,        // User ID who added
  createdAt: DateTime,
  updatedAt: DateTime,
)
```

#### ListPermissions
```dart
ListPermissions(
  anyoneCanEdit: bool,     // All participants can edit
  anyoneCanInvite: bool,   // All participants can invite others
  anyoneCanDelete: bool,   // All participants can delete list
)
```

### Database Schema

#### Sembast (Local)

- **Store**: `shopping_lists` → Map<String, ShoppingList>
- **Store**: `shopping_items` → Map<String, ShoppingItem>
- **Store**: `user_preferences` → Map<String, UserPreferences>
- **Store**: `sync_queue` → List<SyncOperation>

#### Firestore (Cloud)

```
/users/{userId}
  - profile data
  - settings
  
/shopping_lists/{listId}
  - list metadata
  - permissions
  
/shopping_items/{itemId}
  - item data
  - listId reference
  
/shared_lists/{userId}/lists/{listId}
  - user's access to shared lists
```

---

## Development Workflow

### Before Starting Development

1. **Read Documentation**:
   - This AI Development Guide (current file)
   - `CODING_STANDARDS.md` for code conventions
   - `README.md` for setup instructions

2. **Understand Current State**:
   - Review existing code in the feature you're modifying
   - Check for related tests in `test/` directory
   - Look for similar patterns in other features

3. **Plan Your Changes**:
   - Identify affected layers (presentation, domain, data)
   - Consider backward compatibility
   - Think about testing strategy

### Development Process

1. **Create Feature Branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Write Tests First (TDD)**:
   - Unit tests for business logic
   - Widget tests for UI components
   - Golden tests for theme components

3. **Implement Changes**:
   - Follow existing patterns
   - Keep commits atomic and descriptive
   - Run code generation when needed:
     ```bash
     dart run build_runner build --delete-conflicting-outputs
     ```

4. **Format & Lint**:
   ```bash
   dart format .
   dart analyze
   ```

5. **Run Tests**:
   ```bash
   flutter test
   flutter test --coverage  # For coverage report
   ```

6. **Update Documentation**:
   - Add/update code comments
   - Update README if user-facing changes
   - Update this guide if architectural changes

### Code Generation

Run this command after modifying:
- Freezed models (`@freezed` classes)
- JSON serialization (`@JsonSerializable`)
- Riverpod providers (`@riverpod` annotations)

```bash
dart run build_runner build --delete-conflicting-outputs
```

**Important**: Always commit generated `.g.dart` and `.freezed.dart` files.

### Testing Strategy

| Test Type | What to Test | Location |
|-----------|-------------|----------|
| **Unit Tests** | Repository logic, business rules, utilities | `test/features/*/data/` |
| **Widget Tests** | UI components, user interactions | `test/app/`, `test/features/*/presentation/` |
| **Golden Tests** | Theme components, visual consistency | `test/app/theme/` |
| **Integration Tests** | End-to-end flows (future) | `integration_test/` |

---

## AI-Specific Guidelines

### Understanding Your Role

As an AI assistant, you are a **collaborative partner** in developing Listly. Your responsibilities:

1. **Understand Context**: Always read related files before making changes
2. **Maintain Consistency**: Follow existing patterns and conventions
3. **Ensure Quality**: Write tests, handle errors, consider edge cases
4. **Communicate Clearly**: Explain your changes and reasoning
5. **Ask When Uncertain**: If requirements are ambiguous, ask for clarification

### Decision-Making Framework

When faced with implementation choices, prioritize:

1. **Consistency** > Innovation (follow existing patterns)
2. **Simplicity** > Cleverness (readable code over clever tricks)
3. **Testability** > Speed (write testable code even if slower to implement)
4. **User Experience** > Developer Convenience (prioritize user needs)
5. **Long-term Maintainability** > Short-term Wins

### Common Pitfalls to Avoid

❌ **Don't**:
- Disable linting rules
- Use global mutable state
- Bypass repository abstractions
- Ignore null safety
- Skip writing tests
- Hardcode strings (use localization)
- Directly mutate Freezed objects
- Use `print()` for logging (use proper logging when implemented)
- Create tight coupling between features
- Guess at requirements (ask instead)

✅ **Do**:
- Follow Clean Architecture layers
- Use Riverpod for dependency injection
- Write immutable data classes with Freezed
- Handle errors gracefully
- Write comprehensive tests
- Use localization for all user-facing strings
- Create new objects with `copyWith()`
- Use structured logging when available
- Keep features independent
- Seek clarification when needed

### File Creation Guidelines

When creating new files:

1. **Models** (`lib/shared/models/`):
   ```dart
   import 'package:freezed_annotation/freezed_annotation.dart';
   
   part 'model_name.freezed.dart';
   part 'model_name.g.dart';
   
   @freezed
   class ModelName with _$ModelName {
     @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
     const factory ModelName({
       required String id,
       // ... other fields
     }) = _ModelName;
     
     factory ModelName.fromJson(Map<String, dynamic> json) =>
         _$ModelNameFromJson(json);
   }
   ```

2. **Repositories** (`lib/features/*/data/`):
   ```dart
   import 'package:listly/shared/repositories/base_repository.dart';
   
   abstract class EntityRepository implements BaseRepository<Entity, String> {
     // Feature-specific methods
   }
   
   class LocalEntityRepository implements EntityRepository {
     // Implementation using Sembast
   }
   ```

3. **Providers** (`lib/features/*/data/` or `lib/shared/providers/`):
   ```dart
   import 'package:riverpod_annotation/riverpod_annotation.dart';
   
   part 'provider_name.g.dart';
   
   @riverpod
   EntityRepository entityRepository(EntityRepositoryRef ref) {
     return LocalEntityRepository(ref.watch(databaseProvider));
   }
   ```

4. **UI Widgets** (`lib/features/*/presentation/` or `lib/app/theme/components/`):
   ```dart
   import 'package:flutter/material.dart';
   import 'package:flutter_riverpod/flutter_riverpod.dart';
   
   class WidgetName extends ConsumerWidget {
     const WidgetName({super.key});
     
     @override
     Widget build(BuildContext context, WidgetRef ref) {
       // Implementation
     }
   }
   ```

5. **Tests** (`test/` mirroring `lib/` structure):
   ```dart
   import 'package:flutter_test/flutter_test.dart';
   import 'package:mockito/mockito.dart';
   
   void main() {
     group('FeatureName', () {
       test('should ...', () {
         // Test implementation
       });
     });
   }
   ```

### Handling User Requests

When a user asks you to implement a feature:

1. **Clarify Requirements**:
   - What is the expected behavior?
   - Are there edge cases to consider?
   - How should errors be handled?
   - Does this affect existing features?

2. **Plan Implementation**:
   - Which layers need changes? (presentation, domain, data)
   - What models/repositories are needed?
   - What tests should be written?
   - Are there localization needs?

3. **Implement Incrementally**:
   - Start with domain models
   - Add repository layer
   - Create providers
   - Build UI components
   - Write tests
   - Run code generation

4. **Verify Quality**:
   - Format code
   - Run linter
   - Execute tests
   - Check coverage
   - Test manually if possible

5. **Document Changes**:
   - Add code comments
   - Update relevant documentation
   - Explain changes to user

---

## Common Tasks & Patterns

### Adding a New Feature

**Example**: Adding a "Favorites" feature to mark favorite lists

1. **Create Domain Model** (`lib/shared/models/user_favorites.dart`):
   ```dart
   @freezed
   class UserFavorites with _$UserFavorites {
     const factory UserFavorites({
       required String userId,
       @Default([]) List<String> favoriteListIds,
       required DateTime updatedAt,
     }) = _UserFavorites;
     
     factory UserFavorites.fromJson(Map<String, dynamic> json) =>
         _$UserFavoritesFromJson(json);
   }
   ```

2. **Create Repository** (`lib/features/favorites/data/favorites_repository.dart`):
   ```dart
   abstract class FavoritesRepository {
     Future<UserFavorites?> getFavorites(String userId);
     Future<void> addFavorite(String userId, String listId);
     Future<void> removeFavorite(String userId, String listId);
     Stream<UserFavorites?> watchFavorites(String userId);
   }
   ```

3. **Implement Repository** (`lib/features/favorites/data/local_favorites_repository.dart`)

4. **Create Provider** (`lib/features/favorites/data/favorites_provider.dart`):
   ```dart
   @riverpod
   FavoritesRepository favoritesRepository(FavoritesRepositoryRef ref) {
     return LocalFavoritesRepository(ref.watch(databaseProvider));
   }
   ```

5. **Create UI** (`lib/features/favorites/presentation/favorite_button.dart`)

6. **Write Tests** (`test/features/favorites/`)

7. **Run Code Generation**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

### Adding Localization

1. **Add English Translation** (`lib/shared/localization/en_translations.dart`):
   ```dart
   static const Map<String, dynamic> en_US = {
     'featureName': {
       'title': 'Feature Title',
       'description': 'Feature description',
       'action': 'Action Button',
     }
   };
   ```

2. **Add French Translation** (`lib/shared/localization/fr_translations.dart`):
   ```dart
   static const Map<String, dynamic> fr_FR = {
     'featureName': {
       'title': 'Titre de la fonctionnalité',
       'description': 'Description de la fonctionnalité',
       'action': 'Bouton d\'action',
     }
   };
   ```

3. **Use in Code**:
   ```dart
   Text(appLocalization.getString('featureName.title'))
   ```

### Creating a New Screen

1. **Define Route** (`lib/app/navigation/routes/feature_routes.dart`):
   ```dart
   GoRoute(
     path: '/feature',
     name: 'feature',
     builder: (context, state) => const FeatureScreen(),
   )
   ```

2. **Register Route** (`lib/app/navigation/navigation.dart`):
   - Add route to GoRouter configuration

3. **Create Screen Widget** (`lib/features/feature/presentation/feature_screen.dart`):
   ```dart
   class FeatureScreen extends ConsumerWidget {
     const FeatureScreen({super.key});
     
     @override
     Widget build(BuildContext context, WidgetRef ref) {
       return Scaffold(
         appBar: AppBar(
           title: Text(appLocalization.getString('feature.title')),
         ),
         body: // Screen content
       );
     }
   }
   ```

4. **Navigate to Screen**:
   ```dart
   context.goNamed('feature');
   ```

### Implementing Offline-First Data Sync

**Pattern**: Local-first with background sync

1. **Write to Local Database**:
   ```dart
   Future<void> create(ShoppingList list) async {
     // Save to Sembast immediately
     await _localStore.record(list.id).put(_db, list.toJson());
     
     // Queue for background sync
     await _syncQueue.add(SyncOperation(
       type: OperationType.create,
       entityType: 'shopping_list',
       entityId: list.id,
       data: list.toJson(),
     ));
   }
   ```

2. **Background Sync Service** (to be implemented):
   - Monitor sync queue
   - Push changes to Firestore when online
   - Handle conflicts (last write wins by timestamp)
   - Retry failed operations

3. **Listen to Remote Changes**:
   ```dart
   Stream<List<ShoppingList>> watch() {
     // Merge local and remote streams
     return StreamGroup.merge([
       _localStore.stream().map(_deserialize),
       _firestoreCollection.snapshots().map(_deserialize),
     ]);
   }
   ```

### Adding Theme Components

1. **Create Component** (`lib/app/theme/components/custom_button.dart`):
   ```dart
   class CustomButton extends StatelessWidget {
     final String label;
     final VoidCallback? onPressed;
     
     const CustomButton({
       super.key,
       required this.label,
       this.onPressed,
     });
     
     @override
     Widget build(BuildContext context) {
       final theme = Theme.of(context);
       return ElevatedButton(
         onPressed: onPressed,
         style: ElevatedButton.styleFrom(
           // Use theme colors
         ),
         child: Text(label),
       );
     }
   }
   ```

2. **Write Tests** (`test/app/theme/components/custom_button_test.dart`):
   ```dart
   void main() {
     group('CustomButton', () {
       testWidgets('renders correctly', (tester) async {
         await tester.pumpWidget(
           MaterialApp(
             home: Scaffold(
               body: CustomButton(label: 'Test', onPressed: () {}),
             ),
           ),
         );
         expect(find.text('Test'), findsOneWidget);
       });
     });
   }
   ```

### Error Handling Pattern

```dart
Future<List<ShoppingList>> getAll() async {
  try {
    final records = await _store.find(_db);
    return records.map((r) => ShoppingList.fromJson(r.value)).toList();
  } on DatabaseException catch (e) {
    // Handle database-specific errors
    throw RepositoryException('Failed to fetch shopping lists: ${e.message}');
  } catch (e) {
    // Handle unexpected errors
    throw RepositoryException('Unexpected error: $e');
  }
}
```

---

## Project-Specific Context

### Why This Architecture?

1. **Offline-First**: Critical for grocery shopping (poor connectivity in stores)
2. **Clean Architecture**: Enables independent testing and maintainability
3. **Riverpod**: Type-safe, compile-time DI with excellent developer experience
4. **Freezed**: Eliminates boilerplate for immutable data classes
5. **Sembast**: Lightweight NoSQL database perfect for offline-first mobile apps
6. **Firebase**: Mature ecosystem for auth, real-time sync, and cloud functions
7. **Mobile-First**: Optimized for on-the-go shopping experience on phones

### Design Decisions

| Decision | Rationale |
|----------|-----------|
| Local-first sync | Shopping lists must work without internet |
| Feature-first structure | Scales better than layer-first for complex apps |
| Riverpod over Provider | Better type safety and code generation |
| Sembast over SQLite | Simpler API, better for document-style data |
| GoRouter over Navigator 2.0 | Declarative routing with less boilerplate |
| Freezed over manual classes | Reduces boilerplate, ensures immutability |
| Mobile-only (iOS/Android) | Focus on core use case: shopping on-the-go |
| Freemium with ads | Sustainable monetization without paywalling features |

### Future Considerations

1. **Conflict Resolution**: Currently "last write wins"; may need CRDT in future
2. **Optimization**: May need pagination for users with 100+ lists
3. **Permissions**: Current model is simple; may need role-based access control
4. **Analytics**: Privacy-focused analytics to be added later
5. **Monetization**: Ad integration for free tier and premium subscription system
6. **Ad Platform**: Selection of ad SDK (Google AdMob, Facebook Audience Network, etc.)

---

## Resources

### Documentation

- **Flutter**: https://flutter.dev/docs
- **Riverpod**: https://riverpod.dev
- **GoRouter**: https://pub.dev/packages/go_router
- **Freezed**: https://pub.dev/packages/freezed
- **Sembast**: https://pub.dev/packages/sembast
- **Firebase**: https://firebase.google.com/docs/flutter

### Internal Files

- `CODING_STANDARDS.md`: Code conventions and standards
- `README.md`: Setup and getting started
- `pubspec.yaml`: Dependencies and metadata
- `analysis_options.yaml`: Linting rules

### Getting Help

If you encounter issues or need clarification:
1. Check existing code for similar patterns
2. Review relevant tests for expected behavior
3. Consult documentation links above
4. Ask the user for clarification on requirements

---

## Changelog

This document should be updated when:
- Major architectural decisions are made
- New features significantly impact the codebase
- Development workflow changes
- New patterns or conventions are established

### Version History

**v1.1.0** - 2025-10-27
- Added comprehensive Monetization Strategy section
- Defined hybrid freemium model with AI-powered premium tier
- Established pricing structure ($2.99/mo, $24.99/yr, $49.99 lifetime)
- Documented conservative ad strategy (banner + action-based interstitial)
- Outlined AI feature differentiation (limited free vs. unlimited premium)
- Created 4-phase implementation roadmap
- Added economic model and unit economics analysis
- Defined success metrics and KPIs

**v1.0.0** - 2025-10-27
- Initial AI Development Guide
- Project overview and goals
- Technical specifications
- Architecture deep dive
- Development workflow
- AI-specific guidelines
- Common tasks and patterns

**Author**: Hugo (with AI assistance)

