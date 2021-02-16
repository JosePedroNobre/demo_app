**Project information**

 - `BLOC` and `repository` pattern
 - Generic API `response` and `status` class
 - Handling exceptions in a generic way
 - Serialization of a a model class
 - Usage of generic widgets for loading and error prompt
 - SVG compatibility already built in
 - Simplified models according to the best practices by google on documentation (https://flutter.dev/docs/development/data-and-backend/json)
      - Generate models in the code by running (`flutter pub run build_runner build`) (1)
      - Clean models ( `flutter packages pub run build_runner build --delete-conflicting-outputs`)

**After opening the project for the first time or if Pubspec is updated do:**

   1) `flutter pub get`
   2) `sudo gem install cocoapods`
   3) `pod install`
   4) cd ios and then `pod install`
   5) `flutter pub run build_runner build`(When a new model is added)
   6) `flutter packages pub run build_runner build --delete-conflicting-outputs`


RELEASES

**Run app** 
`flutter run lib/main.dart`  

**Make ios buid**
 1) `flutter build ios lib/main.dart`

 **Make android buid**
 1) `flutter build apk lib/main.dart`