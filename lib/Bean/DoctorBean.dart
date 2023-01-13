class DoctorBean {
  late String name;
  late String surname;
  late String password;
  late String birth;
  late String email;
  late String phone_number;

  DoctorBean(String name, String surname, String password, String birth,
      String email, String phone_number) {
    this.name = name;
    this.surname = surname;
    this.password = password;
    this.birth = birth;
    this.email = email;
    this.phone_number = phone_number;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "nome: " +
        name +
        "\n" +
        "cognome: " +
        surname +
        "\n"
            "email: " +
        email +
        "\n" +
        "password: " +
        password +
        "\n"
            "birth: " +
        birth +
        "\n" +
        "phone_number: " +
        phone_number;
  }
}
