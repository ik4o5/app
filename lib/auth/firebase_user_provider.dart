import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class EditorFirebaseUser {
  EditorFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

EditorFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<EditorFirebaseUser> editorFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<EditorFirebaseUser>(
      (user) {
        currentUser = EditorFirebaseUser(user);
        return currentUser!;
      },
    );
