# NFDrink

A Flutter application for an IoT solution that reads NFC tags to verify the authenticity of liquor bottles and other sealed packaging. NFDrink provides a secure way to authenticate products and track their usage through NFC technology.

## 🍾 Features

### For Users
- **NFC Authentication**: Scan NFC tags on bottles to verify authenticity
- **Product Information**: View detailed information about scanned products
- **Scan History**: Track all your previous scans with timestamps and locations
- **User Authentication**: Secure login and registration system
- **Real-time Validation**: Instant feedback on product authenticity

### For Administrators
- **Product Management**: Add, edit, and manage product information
- **Analytics Dashboard**: View comprehensive analytics and scan statistics
- **Bottle Tracking**: Monitor individual bottle usage and scan patterns
- **User Management**: Manage user accounts and permissions
- **Data Export**: Export scan data and analytics reports

## 🏗️ Architecture

### Tech Stack
- **Frontend**: Flutter (Dart)
- **Backend**: AWS Amplify
- **Authentication**: AWS Cognito
- **Database**: AWS AppSync (GraphQL)
- **Storage**: AWS S3
- **NFC**: Flutter NFC Kit
- **State Management**: Provider Pattern

### Key Components
- **Models**: Products, Bottles, Scans, AdminUsers
- **Providers**: NFC, Users, Bottles, Products
- **Pages**: User interface (scan, results) and Admin interface (analytics, management)
- **Services**: AWS Amplify integration for backend services

## 📱 Screenshots

*[Screenshots would be added here]*

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=2.18.2)
- Dart SDK (>=2.18.2)
- Android Studio / VS Code
- NFC-enabled device for testing
- AWS Account (for backend services)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/NFDrink.git
   cd NFDrink
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure AWS Amplify**
   - Set up AWS Amplify backend
   - Configure authentication, API, and storage
   - Update `amplifyconfiguration.dart` with your AWS credentials

4. **Run the application**
   ```bash
   flutter run
   ```

### Environment Setup

1. **Android Configuration**
   - Ensure NFC is enabled on your device
   - Add NFC permissions to `android/app/src/main/AndroidManifest.xml`

2. **iOS Configuration**
   - Add NFC capabilities in Xcode
   - Configure NFC usage description

## 📋 Usage

### For End Users
1. **Register/Login**: Create an account or sign in
2. **Scan Bottles**: Tap the NFDrink logo to scan NFC tags
3. **View Results**: Get instant feedback on product authenticity
4. **Check History**: Review your previous scans

### For Administrators
1. **Access Admin Panel**: Login with admin credentials
2. **Manage Products**: Add new products and configure NFC tags
3. **Monitor Analytics**: View scan statistics and user activity
4. **Export Data**: Download reports and analytics

## 🔧 Configuration

### AWS Amplify Setup
The application uses AWS Amplify for backend services. Configure the following:

- **Authentication**: AWS Cognito for user management
- **API**: GraphQL API for data operations
- **Storage**: S3 for image storage
- **Analytics**: Optional analytics tracking

### NFC Configuration
- Ensure NFC is properly configured on test devices
- Test with various NFC tag types
- Configure appropriate permissions

## 📊 Data Models

### Products
- Product name, net content, admin association
- S3 image storage for product images
- Creation and update timestamps

### Bottles
- Unique bottle identification
- Year, lot number, product association
- Scan history tracking

### Scans
- Scan timestamps and locations
- User association
- Scan results and metadata

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## 🆘 Support

For support and questions:
- Create an issue in the GitHub repository
- Contact the development team
- Check the documentation for common issues


**NFDrink**

