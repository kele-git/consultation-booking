import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    } else if (Platform.isAndroid) {
      return android;
    } else if (Platform.isIOS) {
      return ios;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAuNeua1ROPQGLo4-jRPDxLFytAz3oidM4',
    appId: '1:672341438364:web:5c479dec65a5d74f6b2259',
    messagingSenderId: '672341438364',
    projectId: 'student-portal-b19f0',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',
    appId: '1:672341438364:android:YOUR_ANDROID_APP_ID',
    messagingSenderId: '672341438364',
    projectId: 'student-portal-b19f0',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: '1:672341438364:ios:YOUR_IOS_APP_ID',
    messagingSenderId: '672341438364',
    projectId: 'student-portal-b19f0',
  );
}