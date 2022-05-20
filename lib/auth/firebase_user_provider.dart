import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class McAppFirebaseUser {
  McAppFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

McAppFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<McAppFirebaseUser> mcAppFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<McAppFirebaseUser>((user) => currentUser = McAppFirebaseUser(user));
