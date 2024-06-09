# MoneyBuddy

## Overview

Money Manager is a mobile application built with Flutter and Dart, designed to help users manage their personal finances effectively. The application allows users to track their income and expenses, view their transaction history, and visualize their financial data with intuitive charts. All data is securely stored and synchronized using Firebase Firestore, ensuring users can access their financial information from any device.

## Features

- **Add Income and Expenses**: Easily add new income and expense entries.
- **Transaction History**: View a comprehensive history of all financial transactions.
- **Data Visualization**: Visualize financial data through interactive charts.
- **Firebase Integration**: Secure data storage and synchronization using Firebase Firestore.
- **User Authentication**: Secure login and registration using Firebase Authentication.
- **Responsive UI**: Modern, intuitive, and responsive user interface designed with Flutter.

## Installation

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Firebase Account: [Firebase Console](https://console.firebase.google.com/)

### Steps

1. **Clone the Repository**

   git clone https://github.com/dmouze/MoneyBuddy.git
   cd MoneyBuddy

2. **Install Dependencies**
   flutter pub get

3. **Configure Firebase**
- Create a new project in the Firebase Console.
- Add an Android app to your Firebase project.
- Download the google-services.json file and place it in the android/app directory.
- Enable Firestore and Authentication in the Firebase Console.

4. **Run the App**
  flutter run

 ## Usage
- **Register/Login:** Register a new account or login with existing credentials.
- **Add Transactions:** Use the input fields to add new income or expense entries.
- **View History:** Access the transaction history to review past entries.
- **Visualize Data:** Use the charts to gain insights into your financial status.

## Technologies Used
- **Flutter:** For building the mobile application.
- **Dart:** The programming language used by Flutter.
- **Firebase Firestore:** For real-time database and data synchronization.
- **Firebase Authentication:** For secure user authentication.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
