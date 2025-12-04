# Live Auction

A real-time auction application that allows users to place bids instantly on items using WebSockets. Experience the thrill of live bidding with immediate updates and a seamless user interface.

## Screenshots

| SignUp Screen | Login Screen | Auction Screen |
|:---:|:---:|:---:|
| <img width="220" height="956" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-11-29 at 15 24 01" src="https://github.com/user-attachments/assets/d9c90fe8-7e12-4bf1-9912-f33d43ecdcc6" /> | <img width="220" height="956" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-11-29 at 15 17 51" src="https://github.com/user-attachments/assets/8adfe1cd-58d1-4312-8420-80030b1b144a" /> | <img width="220" height="956" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-11-29 at 15 17 46" src="https://github.com/user-attachments/assets/c3a8c85b-b8eb-4098-a1b5-a7c03472d424" /> |


## Features

*   **Real-time Bidding**: Place bids and see updates instantly across all connected devices using Socket.io.
*   **User Authentication**: Secure login and registration system with JWT authentication.
*   **Live Updates**: Dynamic UI that updates in real-time without refreshing the page.
*   **Clean Architecture**: Built with a scalable and maintainable codebase using Clean Architecture principles.
*   **Localization**: Supports multiple languages (English, Arabic, Spanish).
*   **Responsive Design**: Optimized for a great experience on various screen sizes.

## Tech Stack

### Frontend (Mobile App)
*   **Framework**: [Flutter](https://flutter.dev/)
*   **State Management**: [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
*   **Architecture**: Clean Architecture (Presentation, Domain, Data layers)
*   **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it)
*   **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
*   **Networking**: [Socket.io Client](https://pub.dev/packages/socket_io_client), [HTTP](https://pub.dev/packages/http)

### Backend (API & WebSocket)
*   **Runtime**: [Node.js](https://nodejs.org/)
*   **Framework**: [Express.js](https://expressjs.com/)
*   **Real-time Engine**: [Socket.io](https://socket.io/)
*   **Authentication**: JSON Web Tokens (JWT)

## Getting Started

Follow these steps to set up the project locally.

### Prerequisites
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
*   [Node.js](https://nodejs.org/) installed.

### Backend Setup

1.  Navigate to the backend directory:
    ```bash
    cd backend
    ```

2.  Install dependencies:
    ```bash
    npm install
    ```

3.  Start the server:
    ```bash
    node server.js
    ```
    The server will start on `http://localhost:3000`.

### Frontend Setup

1.  Navigate to the frontend directory:
    ```bash
    cd frontend
    ```

2.  Install dependencies:
    ```bash
    flutter pub get
    ```

3.  Run the application:
    ```bash
    flutter run
    ```

## Environment Variables

The backend server uses the following environment variables. You can set them in a `.env` file in the `backend` directory (optional for development).

| Variable | Description | Default |
| :--- | :--- | :--- |
| `PORT` | The port number for the server to listen on. | `3000` |

## Project Structure

The frontend follows Clean Architecture principles:

*   **`lib/config`**: App configuration, routes, themes, and localization.
*   **`lib/core`**: Shared components, utilities, and base classes.
*   **`lib/features`**: Feature-specific code (Auth, Auction), divided into:
    *   **`data`**: Data sources, models, and repository implementations.
    *   **`domain`**: Entities, repository interfaces, and use cases.
    *   **`presentation`**: BLoCs, screens, and widgets.

## Testing

The project includes a comprehensive suite of tests to ensure reliability and correctness.

### Unit Tests
Focus on testing individual components in isolation, including:
*   **Domain Layer**: Use cases are tested to verify business logic.
*   **Data Layer**: Models (JSON serialization) and Repositories (mocking data sources) are tested.
*   **Presentation Layer**: Cubits are tested using `bloc_test` to verify state changes.

### Widget Tests
Verify that UI components render correctly and interact as expected.
*   **Screens**: `AuthScreen` and `AuctionScreen` are tested for correct rendering and localization.
*   **Widgets**: Individual widgets are tested in isolation.

### Running Tests

To run all tests:
```bash
flutter test
```
