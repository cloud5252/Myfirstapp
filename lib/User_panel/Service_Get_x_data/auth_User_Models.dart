class Models {
  final String uid;
  final String username;
  final String email;
  final String userimage;
  final String userdivicetoken;

  final String useraddress;
  final String street;
  final bool isaddmin;
  final bool isactive;
  final dynamic createdon;

  Models({
    required this.uid,
    required this.username,
    required this.email,
    required this.userimage,
    required this.userdivicetoken,
    required this.useraddress,
    required this.street,
    required this.isaddmin,
    required this.isactive,
    required this.createdon,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      "userimage": userimage,
      "userdivicetoken": userdivicetoken,
      "useraddress": useraddress,
      "street": street,
      "isaddmin": isaddmin,
      "isactive": isactive,
      "createdon": createdon,
    };
  }
}
