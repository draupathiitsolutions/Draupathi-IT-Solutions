# 🌾 RiceKing

### A Bridge Between Farmers and Service Providers

RiceKing is a mobile application developed using **Flutter** with **Firebase** integration to connect farmers with various agricultural service providers.  
The platform facilitates efficient service booking, communication, and management—all in real time and available in **Tamil**, **English**, and **Telugu**.

---

## 🧩 Project Overview
**Project Title:** RiceKing  
**Type:** Startup Application  
**Platform:** Mobile (Android & iOS)  
**Tech Stack:** Flutter + Firebase + Google Cloud  

RiceKing acts as a **digital marketplace** connecting farmers with agricultural service providers such as machinery owners, labor contractors, nursery suppliers, and more.  
The app ensures smooth service discovery, booking, and communication between users and vendors.

---

## 🎯 Purpose & Objectives
- To create a single digital platform connecting **farmers** and **agri-service providers**.
- To make service booking and management easy, transparent, and available in **multiple languages**.
- To provide **real-time updates**, notifications, and admin monitoring for efficient operations.

---

## ⚙️ Main Features

- **Phone number OTP authentication**
- **Three-tier architecture:**  
  - Farmer (User)  
  - Vendor (Service Provider)  
  - Admin (App Owner)
- **Language support:** Tamil, English, Telugu  
- **Firebase Cloud Messaging** for notifications  
- **Real-time data updates** using Cloud Firestore  
- **Admin control:** Approve vendors, manage data, handle reports, and contact users/vendors  
- **Vendor dashboard:** Manage services, bookings, and profile  
- **User dashboard:** Book services, view booking status, and manage personal info  
- **Geo-location** support to show real-time location  
- **Service Categories (9 total):**  
  - Transplanter Operator  
  - Transplanter Owner  
  - Nursery Mat Supplier  
  - Sand Nursery Maker  
  - Drone Services Provider  
  - Straw Baler Owner  
  - Paddy Grain Merchant  
  - Labour Provider  
  - Aana Sakthi  

---

## 👥 Target Users
- **Primary Users:** Farmers (Service Seekers)  
- **Secondary Users:** Service Providers (Vendors)  
- **Tertiary Users:** Admins / App Owners  

---

## 🌍 Multi-language Support
RiceKing supports:
- Tamil
- English
- Telugu

Using Flutter’s localization and Google Translator integration for smooth language switching.

---

## 🧠 Technology Stack

### **Frontend**
- Flutter (Dart)

### **Backend**
- Firebase Authentication  
- Cloud Firestore (Realtime Database)  
- Firebase Cloud Messaging  
- Firebase Storage  
- Google Cloud Platform (for storage and APIs)

### **Flutter Packages Used**
dependencies:
  - firebase_auth:
  - cloud_firestore:
  - firebase_core:
  - firebase_storage:
  - firebase_messaging:
  - flutter_local_notifications:
  - app_badge_plus:
  - googleapis:
  - googleapis_auth:
  - firebase_app_check:
  - firebase_ai:
  - google_fonts:
  - pinput:
  - flutter_spinkit:
  - image_picker:
  - table_calendar:
  - translator:
  - flutter_markdown:
  - geolocator:
  - geocoding:
  - stylish_bottom_bar:
  - another_telephony: 
  - url_launcher:

---

## 🧱 Project Architecture & Code Documentation
**📁 Folder Overview**

The RiceKing mobile application follows a modular MVC-style structure, ensuring scalability, easy maintenance, and separation of concerns.

~~~
lib/
|-- function/
│-- pages/
│-- widget/
│-- firebase_options.dart
│-- main.dart
~~~


**1️⃣ main.dart**

The entry point of the application.
Initializes Firebase using firebase_options.dart.
Defines the root widget and sets up routing to all main pages (user, vendor, admin).
Handles app theme and localization setup (Tamil, English, Telugu).

**2️⃣ firebase_options.dart**

Auto-generated configuration file by Firebase CLI.
Contains Firebase API keys, project ID, and app ID for connecting Flutter with Firebase.

**⚙️ Function Layer (/function)**
| File                        | Description                                                                                                            |
| --------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **`appFunction.dart`**      | Contains reusable app-wide utility functions — such as data validation, localization handling, and navigation helpers. |
| **`dataBaseFunction.dart`** | Encapsulates all Firebase CRUD operations (read/write/update/delete). Manages interaction with Firestore and Storage.  |

**🧩 Pages Layer (/pages)**

All screens are grouped based on user roles and app sections.

**👑 Admin Pages (/pages/admin)**

| File                          | Description                                                          |
| ----------------------------- | -------------------------------------------------------------------- |
| **`admin_home_page.dart`**    | Main dashboard for admin with quick actions and statistics.          |
| **`admin_notification.dart`** | Displays push notifications and system alerts for the admin.         |
| **`admin_payment.dart`**      | Manages payment transactions and vendor settlements.                 |
| **`admin_report.dart`**       | Shows summarized data on user activity, service usage, and payments. |
| **`admin_user_view.dart`**    | Displays all registered farmers with detailed profiles.              |
| **`admin_vendor_view.dart`**  | Shows a list of registered vendors and their status.                 |
| **`view/user_page.dart`**     | Detailed user view for admin access.                                 |
| **`view/vendor_accept.dart`** | Interface for approving or rejecting vendor registration requests.   |
| **`view/vendor_extend.dart`** | Allows admin to extend vendor service validity or update records.    |

**👨‍🌾 User Pages (/pages/user)**

| File                              | Description                                                              |
| --------------------------------- | ------------------------------------------------------------------------ |
| **`user_home_page.dart`**         | Farmer’s main interface — shows nearby service providers and categories. |
| **`user_book_vendor.dart`**       | Booking screen where the user selects and confirms service requests.     |
| **`user_notification_page.dart`** | Shows notifications related to booking confirmations or updates.         |
| **`user_view_vendor.dart`**       | Displays vendor profile details and reviews.                             |
| **`user_edit_profile.dart`**      | Allows farmers to update their personal details and preferences.         |
| **`user_setting_page.dart`**      | Handles app settings like language, notifications, and preferences.      |
| **`my_info_page.dart`**           | Shows user profile and basic app info.                                   |
| **`filter_page.dart`**            | Provides filters (service type, location, price) for browsing vendors.   |
| **`my_auth_page.dart`**           | Handles login & OTP verification via Firebase Auth.                      |
| **`user_reg_vendor.dart`**        | Form for farmers who also want to register as vendors.                   |

*Vendor Registration Submodule (/user/vendor_reg)*

| File                            | Description                                                    |
| ------------------------------- | -------------------------------------------------------------- |
| **`reg_1.dart` → `reg_5.dart`** | Multi-step vendor registration forms for service providers.  |

| **`SpecialReg/` folder** |
 |------------------------|
| Contains specialized registration forms for each service type:
anna_sakthi.dart — Aana Sakthi registration
dron_services.dart — Drone service provider registration
labor_provider.dart — Labour provider registration
nursery_mat.dart — Nursery mat supplier registration
paddy_grain.dart — Paddy grain merchant registration
sand_nursery.dart — Sand nursery maker registration
straw_baler.dart — Straw baler owner registration
transplanter.dart — Transplanter operator/owner registration |

**🧑‍🔧 Vendor Pages (/pages/vendor)**
| File                              | Description                                                |
| --------------------------------- | ---------------------------------------------------------- |
| **`vendor_home_page.dart`**       | Vendor dashboard showing bookings, reviews, and earnings.  |
| **`vendor_booking_request.dart`** | Displays new incoming service requests from farmers.       |
| **`vendor_booked.dart`**          | Shows list of confirmed bookings.                          |
| **`add_service.dart`**            | Form to add new services offered by the vendor.            |
| **`edit_vendor_profile.dart`**    | Allows vendor to modify their details or business info.    |
| **`modify_service.dart`**         | Edit or update existing services.                          |
| **`vendor_review_page.dart`**     | Displays user feedback and ratings for vendor performance. |

**💬 Common Pages**

| File                    | Description                                                                           |
| ----------------------- | ------------------------------------------------------------------------------------- |
| **`message_page.dart`** | Chat interface for communication between user and vendor.                             |
| **`my_main_page.dart`** | Root navigation controller that switches between user/vendor/admin roles after login. |

**🧱 Widget Layer (/widget)**

Contains all reusable UI components for a consistent design system.

| File                    | Description                                                    |
| ----------------------- | -------------------------------------------------------------- |
| **`button.dart`**       | Custom styled buttons used across app screens.                 |
| **`inputField.dart`**   | Standard input field widget with validation.                   |
| **`online_image.dart`** | Displays network images with caching and fallback options.     |
| **`report.dart`**       | Custom card widget for displaying reports or statistics.       |
| **`staff.dart`**        | UI component for staff/admin cards.                            |
| **`text.dart`**         | Custom text styles and font configurations using Google Fonts. |

---

## 🗄️ Database Structure (Firebase Firestore)

**☁️ Firebase Database Design**

The RiceKing app uses Cloud Firestore as its primary database to manage real-time data flow between Farmers (Users), Vendors (Service Providers), and Admin.
The structure follows a role-based hierarchy, ensuring scalability, performance, and logical separation of data.

**🗂️ Database Collections Overview**

**1️⃣ communication/**

Handles real-time chat between farmers and vendors.

~~~
communication/
  ├── uid/
  │     ├── message/
  │     │     ├── message_id/
  │     │     │     ├── message: "Hello, available tomorrow?"
  │     │     │     ├── messageBy: "user"   # determines message alignment (left/right)
  │     │     │     ├── msgId:
  │     │     │     ├── time: "2025-11-06T08:20"
  │     │     │     ├── userId:
  │     │     │     └── vendorId:
~~~

- Purpose: Enables instant chat between user and vendor for service discussion.
-  Key Use: Used by message_page.dart for communication interface.

**2️⃣ offical/**

Stores administrative and app-wide data.

~~~
offical/
  ├── admin_id/
  │     ├── id: "ADMIN123"
  ├── banner/
  │     ├── banner1: "<image-url>"
  │     ├── banner2: "<image-url>"
  │     ├── banner3: "<image-url>"
~~~

Purpose:
- Keeps global content for the home page highlights (banner images).
Stores official admin account identifiers.
-  Used in:
**`admin_home_page.dart`**,**` user_home_page.dart`** for banner display.

**3️⃣ report/**

Stores user-submitted feedback or issue reports.

~~~
report/
  ├── reportID/
  │     ├── name: "Rajesh"
  │     ├── phone: "+91xxxxxx"
  │     ├── report: "Booking issue with vendor"
  │     └── subject: "Service Delay"
~~~

- Purpose: Enables farmers/vendors to report bugs, feedback, or issues.
- Used in: `report.dart` widget under `/widget/`.

**4️⃣ riceKing/**

Primary user collection — stores farmer profiles, booking data, and notifications.

~~~
riceKing/
  ├── uid/
  │     ├── booked/
  │     │     ├── book_id/
  │     │     │     ├── (18 fields of booking data)
  │     ├── notification/
  │     │     ├── id/
  │     │     │     ├── date:
  │     │     │     ├── reason: "Declined due to unavailability"
  │     │     │     ├── service:
  │     │     │     ├── time: "09:30 AM"
  │     │     │     ├── vendor: "VENDOR123"
  │     ├── waiting/
  │     │     ├── id/
  │     │     │     ├── companyName:
  │     │     │     ├── companyUrl:
  │     │     │     ├── day:
  │     │     │     ├── service:
  │     │     │     ├── status: "pending"
  │     ├── address:
  │     ├── fcmToken:
  │     ├── language:
  │     ├── name:
  │     ├── phone_no:
  │     ├── uid:
  │     └── vendorId:  # null if user is not a vendor
~~~
Purpose:
- Manages user profiles and booking life cycle.
- Each booking flows from `waiting` → `booked` or `notification` (if declined).
- Supports multi-role users (farmers who are also vendors).

Used in:
`user_book_vendor.dart`, `user_notification_page.dart`, `user_home_page.dart`.

**5️⃣ vendors/**

Stores all vendor-related data, bookings, and reviews.

~~~
vendors/
  ├── vendorId/
  │     ├── booked/
  │     │     ├── book_id/
  │     │     │     ├── (18 fields of booking details)
  │     ├── offical/
  │     │     ├── balance/
  │     │     │     ├── amount:
  │     ├── request/
  │     │     ├── id/
  │     │     │     ├── acre:
  │     │     │     ├── address:
  │     │     │     ├── bookId:
  │     │     │     ├── companyUrl:
  │     │     │     ├── day:
  │     │     │     ├── service:
  │     │     │     ├── userId:
  │     │     │     ├── userName:
  │     │     │     └── vendorId:
  │     ├── review/
  │     │     ├── id/
  │     │     │     ├── by: "userId"
  │     │     │     ├── rating: 4.5
  │     │     │     └── review: "Excellent service!"
  │     ├── (13 core fields + nested data for service metadata)
~~~

-  Purpose:
Core vendor management collection,
Stores service data, incoming requests, booked jobs, earnings, and user reviews.

-  Used in:
`vendor_home_page.dart`, `add_service.dart`, `modify_service.dart`, `vendor_review_page.dart`.

**🔁 Booking Flow (User ↔ Vendor ↔ Admin)**

flowchart TD
   
    A[User Books Service] --> B[Data added to riceKing/uid/waiting]
    B --> C[Vendor notified via FCM]
    C --> D{Vendor Action}
    D -->|Approve| E[Moves to riceKing/uid/booked]
    E --> F[Booking added to vendors/vendorId/booked]
    D -->|Decline| G[Moves to riceKing/uid/notification]
    F --> H[Admin monitors via admin_report.dart]

✅ Admin can view, track, and manage all bookings

✅ Vendor manages confirmations and reviews

✅ User gets notifications and can view booking history


**🧠 Data Model Summary**

| Collection         | Main Purpose                           | Key Subcollections                   | Access Roles  |
| ------------------ | -------------------------------------- | ------------------------------------ | ------------- |
| **communication/** | Chat messages                          | message/                             | User ↔ Vendor |
| **offical/**       | Admin & app banners                    | banner/                              | Admin         |
| **report/**        | Issue reporting                        | —                                    | User, Admin          |
| **riceKing/**      | User profiles, bookings, notifications | booked/, waiting/, notification/     | User, Vendor  |
| **vendors/**       | Vendor info, requests, reviews         | booked/, request/, review/, offical/ | Vendor, Admin |

---

##🧾 Data Relationships33

**One-to-One**: Each userId ↔ vendorId (if same person acts as both).

**One-to-Many**:
- A vendor can have multiple bookings.
- A user can have multiple services booked.

**Many-to-Many**: Users and Vendors connected via booking records.

---

## 🔑 Core Functionalities

- OTP-based authentication  
- Vendor approval workflow  
- Service booking and tracking  
- Notification system for updates and booking status  
- Multi-language UI  
- Real-time chat between users and vendors  
- Report and feedback management for admins  

---

## 🚀 Future Enhancements

- AI-based service recommendations
- Payment gateway integration
- Analytics dashboard for admins
- Cloud-based reporting and insights
- Expansion to more regional languages
