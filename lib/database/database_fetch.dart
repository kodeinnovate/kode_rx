class UserModel {
  final String? id;
  final String fullname;
  final String email;
  final String phoneNo;

  const UserModel(
      {this.id,
      required this.fullname,
      required this.email,
      required this.phoneNo});

  toJson() {
    return {'Fullname': fullname, 'Email': email, 'Phone': phoneNo};
  }
}
