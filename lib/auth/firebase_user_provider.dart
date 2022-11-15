import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FitegyFirebaseUser {
  FitegyFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

FitegyFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FitegyFirebaseUser> fitegyFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FitegyFirebaseUser>(
      (user) {
        currentUser = FitegyFirebaseUser(user);
        return currentUser!;
      },
    );
