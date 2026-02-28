# fakestore_onescroll

##  Application Screens

| Screen | Screen | Screen|
|--------|---------|---------|
|<img src="https://github.com/user-attachments/assets/02830b7d-2277-46d1-abef-419aece1cdc8" width="250"/> |<img src="https://github.com/user-attachments/assets/91e3168c-c01d-4159-8d96-d06d6731b76e" width="250"/> |<img src="https://github.com/user-attachments/assets/b90de52b-3aa0-4193-8c86-f609e04be6bf" width="250"/> |
|<img src="https://github.com/user-attachments/assets/de2bfcd2-26d1-4939-90ca-590e358c6c2a" width="250"/> |<img src="https://github.com/user-attachments/assets/e6e470ce-4998-48fa-837c-51d08d49ec77" width="250"/> |<img src="https://github.com/user-attachments/assets/ea7128be-c749-4b38-a178-a0f34e25398e" width="250"/>|



## Overview

- This Flutter app mimics a Daraz-style product listing screen with the following features:
- Collapsible header with banner and search bar
- Sticky tab bar for product categories
- 2–3 tabs showing product lists fetched from Fakestore API
- Single vertical scroll for the entire screen
- Pull-to-refresh on any tab
- Tab switching via tap or horizontal swipe
- Login and profile functionality
- The app uses Sliver-based layout to handle scrolling, sticky headers, and consistent performance.

## Download APK:
[![drive](https://img.shields.io/badge/Click_Here_to_download_APK-000?style=for-the-badge&logo=flutter&logoColor=red)](https://drive.google.com/file/d/1P_WZlCjY_HoilFz3YGqKGe4E6ujVt_Vz/view?usp=sharing)

## Mandatory Explanation 

### Horizontal swipe

- Implemented via GestureDetector.onHorizontalDragEnd on the Sliver content.
- Detects primaryVelocity to change the tab index left or right.
- Limitation: Child widgets may interfere; no smooth animation like TabBarView.

### Vertical scroll ownership
- Single CustomScrollView owns the vertical scroll.
- Ensures header collapse, pinned TabBar, and pull-to-refresh work consistently without duplicate scrolls.
Diagram: Scroll & Gesture Ownership:
```
HomeScreen (StatefulWidget)
│
├─ CustomScrollView  ← Single vertical scroll owner (pull-to-refresh)
│   │
│   ├─ SliverAppBar (Collapsible header + Search + Banner)
│   │
│   ├─ SliverPersistentHeader (Sticky TabBar)
│   │
│   └─ SliverToBoxAdapter
│       └─ GestureDetector (Horizontal swipe)
│           └─ Column / ProductCard (List of products per category)
│
TabBar (inside SliverPersistentHeader)
│   └─ Taps update currentIndex in HomeController
│
HomeController (GetX)
├─ Holds currentIndex
├─ Holds product lists per category (from Fakestore API via `http`)
├─ Manages loading state
├─ Handles pull-to-refresh
└─ Handles goToProfile navigation

```

### Limitations / Trade-offs
    
Feature	Limitation:
- Horizontal swipe	Manual GestureDetector; may conflict with vertical scroll; no smooth swipe animation
- Product rendering	Column renders all items; lazy-loading not implemented
- Search	Static; does not filter API results dynamically
- TabBarView	Not used; could simplify swipe & animation handling

## Architecture & Structure

1. UI Layer

### HomeScreen (StatefulWidget)
Uses CustomScrollView as the single vertical scroll container
Contains:
- SliverAppBar for collapsible header
- SliverPersistentHeader for sticky TabBar
- SliverToBoxAdapter displaying products
- ProductCard (StatelessWidget)
- Displays product image, title, and price
- Reusable for all categories

### State Management

### HomeController (GetX)

Holds:
- Current tab index
- Product lists per category
- Loading state

Methods:
- refreshAllCategories for pull-to-refresh
- getByCategory(category) to fetch/display category products
- initTabController to sync tab index with gestures
- goToProfile for navigation

3. Scroll & Gesture Ownership

## Vertical Scroll
### Owned by: CustomScrollView
Reason:
- Ensures only one vertical scroll exists on the screen
- Handles collapsible header, sticky TabBar, and pull-to-refresh without jitter

Benefit:
- No conflicts between tabs, header, and product list scrolls
- Smooth, continuous vertical scroll across all tabs
- Horizontal Swipe
- Implemented using: GestureDetector wrapping product list

### How it works:

- Detects primaryVelocity of horizontal drag
- If swipe left → next tab
- If swipe right → previous tab

Trade-offs:

- Swipe gesture may conflict with child widgets
- No animation like TabBarView swipe

Alternative:

- TabBarView with controller would handle swipe + tab syncing more robustly

### Product List

- Data Source: Fakestore API (https://fakestoreapi.com/products)
- Rendering: Column inside SliverToBoxAdapter
- Each product displayed via ProductCard

Trade-offs:

- Column renders all items; lazy-loading not implemented
- For large product lists, SliverList or SliverGrid would be more efficient

### Login & Profile

- Simple login implemented using Fakestore API
- SharedPreferences stores login session
- Profile screen shows user info and can be extended for editing

### Pull-to-Refresh

~ RefreshIndicator wraps CustomScrollView
~ Refreshes all categories without affecting scroll position
~ Works from any tab


### Packages Used
Package	Version	Purpose
- http	^1.2.2	Fetch products & login API data from Fakestore API
- get	^4.7.3	State management, routing (HomeController, reactive variables)
- shared_preferences	^2.2.3	Persist login session (e.g., user token)
- cached_network_image	^3.4.0	Efficient image loading for product thumbnails

### How to Run

Clone the repository:
```
git clone https://github.com/kazihabiba201/fakestore_onescroll
```
Navigate to the project folder:
```
cd fakestore_onescroll
```
Get dependencies:
```
flutter pub get
```
Run the app:
```
flutter run
```

