class User {
  static const String collectionName = "collection";
  String? id;

  String? fullName;

  String? userName;

  String? email;

  User({this.id, this.email, this.userName, this.fullName});

  User.formFireStore(Map<String, dynamic>? data) {
    id = data?['id'];
    userName = data?['userName'];
    fullName = data?['fullName'];
    email = data?['email'];
  }

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'fullName': fullName,
    };
  }
}
