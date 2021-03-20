class CurrentUserPatient {
  final String name;
  final String email;
  final String address;

  CurrentUserPatient({this.name, this.email, this.address});

  factory CurrentUserPatient.fromJson(Map<String, dynamic> map) {
    return CurrentUserPatient(
        name: map['name'], email: map['email'], address: map['address']);
  }
}
