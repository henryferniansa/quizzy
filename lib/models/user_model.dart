class UserModel {
  final String uid;
  final String email;
  String? firstName;
  String? secondName;

  UserModel({required this.uid,required this.email, this.firstName, this.secondName});


  factory UserModel.fromMap(Map<String, dynamic>map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
  @override
  String toString(){
    return 'UserMode(uid: $uid, email: $email, firstName: $firstName, secondName: $secondName)';
  }
}
