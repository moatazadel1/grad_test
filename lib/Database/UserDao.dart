import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/Database/Model/user.dart';

class UserDao {
  static CollectionReference<User> getUserCollection() {
    var db = FirebaseFirestore.instance;
    var usersCollection = db.collection(User.collectionName).withConverter(
        fromFirestore: (snapshot, options) =>
            User.formFireStore(snapshot.data()),
        toFirestore: (object, options) => object.toFireStore());
    return usersCollection;
  }

  static Future<void> createUser(User user) {
    var userCollection = getUserCollection();
    var doc = userCollection.doc(user.id);
    return doc.set(user);
  }

  static Future<User?> getUser(String uid) async {
    var doc = getUserCollection().doc(uid);
    var docSnapshot = await doc.get();
    return docSnapshot.data();
  }
}
