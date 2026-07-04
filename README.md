# Payroll Management App

## Overview

This project is a Payroll Management application built using **SwiftUI**, **SwiftData**, and **MVVM Clean Architecture**. It demonstrates a scalable, maintainable, and production-oriented architecture while leveraging Apple's latest frameworks.

**Development Environment**

* Xcode (Latest Version)
* SwiftUI
* SwiftData
* iOS SDK (Latest Supported Version)

## Application Flow

### Payroll List Screen

The application launches with the Payroll List screen, which supports two UI states:

* **Empty State:** If no payroll records exist, a `ContentUnavailableView` is displayed to inform the user that no payrolls have been created.
* **Data State:** Once payroll records are available, they are displayed in a list showing the payroll summary.

A **"+"** button in the navigation toolbar allows users to create a new payroll.

### Create Payroll Screen

Users can create a new payroll by entering employee information, including wage details.

After validating the required fields, tapping the **Save** button persists the payroll data using **SwiftData** and returns the user to the Payroll List screen.

### Payroll Detail Screen

Selecting a payroll from the list navigates to the Payroll Detail screen, where users can review:

* Employee information
* Individual wage details
* Payroll summary
* Total payroll amount
* Tax calculations (if applicable)

This screen provides a consolidated view of all employees associated with the selected payroll.

## Technical Stack

* **Language:** Swift 6
* **UI Framework:** SwiftUI
* **Persistence:** SwiftData
* **Architecture:** MVVM with Clean Architecture
* **Navigation:** SwiftUI NavigationStack
* **State Management:** Observable/ViewModel-based state management
* **Dependency Management:** Native Swift Package Manager (if required)
* **Data Flow:** Unidirectional data flow following MVVM principles

## Architecture Highlights

The project follows **MVVM Clean Architecture** to ensure separation of concerns.

* **Presentation Layer**

  * SwiftUI Views
  * ViewModels
  * Navigation

* **Domain Layer**

  * Business logic
  * Use cases
  * Domain models

* **Data Layer**

  * SwiftData models
  * Repository implementation
  * Persistence operations

This structure improves maintainability, testability, scalability, and code readability.

## Key Features

* SwiftUI-based modern user interface
* SwiftData for local data persistence
* MVVM Clean Architecture
* Empty state using `ContentUnavailableView`
* Create and save payroll records
* Employee management
* Payroll summary calculation
* Payroll detail view with employee wage information
* Navigation using `NavigationStack`
* Reactive UI updates using SwiftUI state management

