import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions are not supported for this platform.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUl36JEFJ01wztRqcTIQGReIAhldkAF0Q',
    appId: '1:773156350653:android:b1473b463080b14799a5d4',
    messagingSenderId: '773156350653',
    projectId: 'jadwalqu-2e770',
    storageBucket: 'jadwalqu-2e770.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDO3wWR5q7EuASCFcE_-LiZeOS58ZJx1ZI',
    appId: '1:773156350653:ios:2ecd2ca346ba4b4499a5d4',
    messagingSenderId: '773156350653',
    projectId: 'jadwalqu-2e770',
    storageBucket: 'jadwalqu-2e770.appspot.com',
    iosBundleId: 'om.app.sonasetiana.schedulequ',
  );
}
