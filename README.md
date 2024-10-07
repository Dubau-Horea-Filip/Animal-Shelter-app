# Animal-Shelter-app

 The Animal-Shelter app is a mobile application that has been built using the Flutter framework for front-end development. The back-end of the application leverages the Spring Boot framework to ease database connectivity and data processing. The data for the application is stored in a relational database that has been designed using MySQL Workbench. 
### Installation

1. **Install Flutter**
   - Download and install Flutter from the official site: [Flutter Install](https://flutter.dev/docs/get-started/install).
   - Follow platform-specific installation instructions (Windows, macOS, or Linux).

2. **Add Flutter and Dart to Your System Path**
   - Add Flutter and Dart to your system’s PATH to run `flutter` commands globally.
   - [Instructions for adding to PATH](https://flutter.dev/docs/get-started/install#update-your-path).

3. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/Animal-Shelter-app.git
   cd Animal-Shelter-app/flutter_animal_shelter

2. Navigate to the Flutter project directory:

    ```bash
    cd Animal-Shelter-app/flutter_animal_shelter
    ```

3. Install Flutter Project Dependencies:

    ```bash
    flutter pub get
    ```

4. Run the Backend Server

    Ensure the backend server is running before launching the Flutter app.

    Navigate to the backend project directory:

    ```bash
    cd ../Animal-Shelter-backend
    ```

    Run the backend (e.g., for Spring Boot):

    ```bash
    ./mvnw spring-boot:run
    ```

    Confirm the backend service is available at [http://localhost:9191](http://localhost:9191).

5. Run the Flutter App

    Navigate back to the Flutter project directory:

    ```bash
    cd ../flutter_animal_shelter
    ```

    Run the Flutter app:

    ```bash
    flutter run
    ```
