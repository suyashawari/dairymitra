# 🐄 Dairy Mitra - Your Modern Milk Management Solution 🥛

**Bridging the gap between dairy farmers and managers with seamless digital efficiency!**

Dairy Mitra is an innovative and user-friendly platform designed to streamline and modernize traditional dairy management practices. This application serves as a digital bridge between rural dairy farmers (contributors) and dairy owners/staff (managers/staff), aiming to promote transparency, efficiency, and data-driven decision-making in the dairy business. Say goodbye to manual registers and notebooks and embrace a new era of digital dairy management!

---

## ✨ Key Features

*   **Role-Based Access:** Tailored dashboards and functionalities for Managers, Staff, and Farmers.
*   **Milk Collection Management:** Easy recording and tracking of daily milk contributions.
*   **Farmer Management:** Register new farmers and manage their profiles and records.
*   **Staff Management:** Managers can add and manage staff accounts.
*   **Payment & History Tracking:** Transparent access to milk rates, payment history, and milk records.
*   **Data-Driven Insights:** View farmer data, staff data, and generate reports for better decision-making.
*   **Secure Authentication:** Robust login for all user roles.
*   **Environment-based API Configuration:** Flexible setup for frontend API endpoints.
*   **Milk Pickup Requests:** Farmers can request milk pickups through the app.

---

## 📋 Roles & Functionalities

The application caters to three primary user roles, each with a specific set of functionalities.

### 👤 User (Initial Interaction)
*   **Splash Screen & Authentication Check:** Initial entry point.
*   **Select Role:** Users choose their role (Farmer, Staff, or Manager) to proceed to the respective login.

### 🐮 Farmer
*   **Login:** Securely access their dashboard.
*   **Farmer Dashboard:**
    *   **View Milk Records:** Check the quantity of milk submitted, including details like date, time, fat content (if applicable), and volume.
    *   **Check Payment History:** Transparent access to payment records for milk supplied.
    *   **Request Milk Pickup:** Schedule or request a pickup for their milk.
    *   **Access Settings:** Manage account-related settings.
    *   **Logout:** Securely exit the application.

### 👨‍💼 Staff
*   **Login:** Securely access their dashboard.
*   **Staff Dashboard:**
    *   **Search Farmers:** Find specific farmer details.
    *   **Add Milk Collection:** Record new milk collection entries from farmers.
    *   **Register New Farmer:** Add new farmers to the system.
        *   ➡️ **Create Farmer Account:** Set up login credentials and profile for the new farmer.
    *   **Manage Milk Collection:** View, update, or manage existing milk collection records.
        *   ➡️ **Update Farmer Records:** Make necessary changes to farmer information or their milk records.
    *   **Logout:** (Implicit, typically part of Access Settings or a general menu).

### 👑 Manager
*   **Login:** Securely access their dashboard.
*   **Manager Dashboard:**
    *   **View Farmer Data:** Access and review data related to all registered farmers.
    *   **View Staff Data:** Access and review data and activities of staff members.
    *   **Add New Staff:** Register new staff members in the system.
        *   ➡️ **Create Staff Account:** Set up login credentials and profile for new staff.
    *   **Logout:** (Implicit, typically part of Access Settings or a general menu).

---

## 📊 Workflow Diagram

<!-- Instructions for adding image are below this code block -->
![Dairy Mitra Workflow](./assets/screenshots/dairymitra_workflow_diagram.png)

*(The image above assumes you have a `dairymitra_workflow_diagram.png` file inside an `assets/screenshots/` directory in your repository.)*

---

## 🛠️ Tech Stack

*   **Frontend:** Flutter
*   **Backend:** Spring Boot, Java 17+
*   **Database:** PostgreSQL
*   **API Tunneling (for development):** ngrok

---

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

#### Backend (Spring Boot)

*   **Java Development Kit (JDK):** Version 17 or higher.
    *   OpenJDK: [Adoptium Temurin](https://adoptium.net/), [Azul Zulu OpenJDK](https://www.azul.com/downloads/?package=jdk), [OpenLogic OpenJDK](https://www.openlogic.com/openjdk-downloads)
    *   Oracle JDK: [Oracle Java SE Downloads](https://www.oracle.com/java/technologies/javase-downloads.html)
*   **IDE (Integrated Development Environment):**
    *   [IntelliJ IDEA](https://www.jetbrains.com/idea/download/)
    *   [Visual Studio Code (VSCode)](https://code.visualstudio.com/download)
    *   [Eclipse IDE for Java Developers](https://www.eclipse.org/downloads/packages/)
*   **Build Tool:** Maven or Gradle (as configured in your Spring Boot project).
*   **Database:** PostgreSQL (ensure it's installed and running).
    *   [Download PostgreSQL](https://www.postgresql.org/download/)
*   **ngrok (Optional, for exposing local API during development):**
    *   [Download ngrok](https://ngrok.com/download)

#### Frontend (Flutter)

*   **Flutter SDK:**
    *   Installation Guide: [Flutter Official Documentation](https://docs.flutter.dev/get-started/install)
*   **Development Environment:**
    *   [Android Studio](https://developer.android.com/studio)
    *   [Visual Studio Code (VSCode)](https://code.visualstudio.com/download)
*   **For Mobile Development (Optional):**
    *   **Android:** Android SDK.
    *   **iOS (macOS only):** Xcode.
*   **Git:** [Download Git](https://git-scm.com/downloads)

---

### ⚙️ Installation & Setup

#### 1. Backend (Spring Boot)

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/YOUR_USERNAME/dairymitra.git # Replace YOUR_USERNAME
    cd dairymitra/backend
    ```
2.  **Configure PostgreSQL Database:**
    *   Ensure PostgreSQL server is running.
    *   Create a new database for the application (e.g., `dairymitra_db`).
    *   Update the `src/main/resources/application.properties` (or `application.yml`) file with your PostgreSQL connection details:
        ```properties
        spring.datasource.url=jdbc:postgresql://localhost:5432/dairymitra_db
        spring.datasource.username=your_postgres_user
        spring.datasource.password=your_postgres_password
        spring.jpa.hibernate.ddl-auto=update # or validate/create depending on your needs
        spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
        # Add other properties as needed
        ```
3.  **Ensure Java 17+ is Installed.** Verify with `java -version`.
4.  **Open in IDE and Build:**
    *   **IntelliJ IDEA:** Open the `backend` folder.
    *   **VSCode:** Open the `backend` folder (requires "Extension Pack for Java").
    *   **Eclipse:** Import as an existing Maven/Gradle project.
    Allow the IDE to download dependencies. You might need to trigger a build manually (e.g., `mvn clean install` or `./gradlew build`).
5.  **Run the Application:**
    *   Use your IDE's run feature on the main Spring Boot application class.
    *   Or run the packaged JAR: `java -jar target/your-app.jar` (Maven) or `java -jar build/libs/your-app.jar` (Gradle).
    The backend server will start (e.g., on port `8080`).

6.  **(Optional) Expose Local API with ngrok:**
    *   Start ngrok: `ngrok http 8080` (if your backend runs on port 8080).
    *   Note the public HTTPS URL provided by ngrok.

#### 2. Frontend (Flutter)

1.  **Navigate to the Frontend Directory:**
    ```bash
    # From the repository root:
    cd dairymitra/frontend
    ```
2.  **Ensure Flutter SDK is Installed:** Verify with `flutter doctor`. Address any issues.
3.  **Create Environment Configuration File:**
    *   In the `frontend` directory, create a `.env` file (e.g., `frontend/.env`).
    *   Add your API endpoint:
        ```env
        APP_NAME="Dairy Mitra"
        API_KEY="http://localhost:8080" # For local backend
        # OR if using ngrok:
        # API_KEY="https://YOUR_NGROK_ID.ngrok-free.app"
        ```
    *   **Important:** Add `frontend/.env` to your `frontend/.gitignore` file.
        ```gitignore
        # In frontend/.gitignore
        .env
        ```
    *   Ensure your Flutter code uses a package like `flutter_dotenv` to load these variables.
4.  **Get Flutter Packages:**
    ```bash
    flutter pub get
    ```
5.  **Open in IDE/Editor and Run:**
    *   **Android Studio / VSCode:** Open the `frontend` folder.
    *   Select a device/emulator and run the application (`flutter run`).

---

## ✅ Testing the Application

Once both backend and frontend are running, you can test the application.

### Example Login Credentials:

*(Ensure these users exist in your database or can be created through the app's manager/staff functionalities.)*

*   **Manager:**
    *   **Username/Email:** `manager@dairy.com`
    *   **Password:** `manager123`
*   **Staff:**
    *   **Username/Email:** `staff1@dairy.com`
    *   **Password:** `staff123`
*   **Farmer:**
    *   **Username/Email:** `farmer101@mail.com`
    *   **Password:** `farmer123`

### Testing Steps:

1.  **Role Selection:** Open the app and select a role.
2.  **Login:** Enter the credentials.
3.  **Dashboard Navigation:** Verify role-specific dashboards and test each feature.
4.  **Data Integrity:** Check if actions in one role reflect correctly for others (e.g., staff adding milk collection should be visible to the farmer).
5.  **Logout:** Test logout functionality.

---

## 🖼️ Application Output (Screenshots)

<!-- Instructions for adding images are below this code block -->

**1. Splash Screen & Role Selection:**
![Splash Screen](https://ibb.co/xSVKhhv4)
![Role Selection](https://ibb.co/FbFghJ8c)

**2. Login Screens:**
![Login](https://ibb.co/JF3JzJWy)


**3. Farmer Dashboard:**
![Farmer Dashboard - Milk Records](https://ibb.co/Z69dTW38)
![Farmer Dashboard - Payment History](https://ibb.co/gGnpCMN)

**4. Staff Dashboard:**
![Staff Dashboard - Add Milk](https://ibb.co/7t2NFFJv)
![Staff Dashboard - Register Farmer](https://ibb.co/7JqP5QcS)

**5. Manager Dashboard:**
![Manager Dashboard - View Farmers](https://ibb.co/B2mctkNh)
![Manager Dashboard - Add Staff](https://ibb.co/HDvfPpw0)

![Manager Dashboard - View Analytics](https://ibb.co/G4rLGc92)
![Manager Dashboard - Milk collection](https://ibb.co/3mm7D9TT)


---

## 🎬 Project Demo Video

Watch a walkthrough of the Dairy Mitra application and its features:

[Watch Dairy Mitra Demo on YouTube](https://youtu.be/fZ_6oslhHZ8)

*(Replace `https://youtu.be/fZ_6oslhHZ8?si=Wt04jC0lU0xzasj2` with the actual link to your project's demo video.)*

---

## 🤝 Contributing

Contributions are welcome! If you'd like to contribute, please fork the repository and use a feature branch. Pull requests are warmly welcome.

1.  Fork the Project (`https://github.com/suyashawari/dairymitra/fork`)
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

---

## 📜 License

Distributed under the MIT License. See `LICENSE` file for more information.

*(Create a `LICENSE` file in your repository root. A common choice is the MIT License. You can find templates online.)*

---

Happy Dairying! 🚀
