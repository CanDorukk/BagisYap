// Android için değerler android/app/google-services.json dosyasından alındı.
// Şu an sadece Android destekleniyor.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => android;

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDo2pnKRBscv1Z0jvNMlmytNBQDtI8LtMI',
    appId: '1:149779929584:android:2b35f46255bc5947b46535',
    messagingSenderId: '149779929584',
    projectId: 'bagisyap',
  );
}
