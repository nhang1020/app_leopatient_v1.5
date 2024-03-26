class User_Pass {
  dynamic userName;
  dynamic passWork;
  dynamic toKen;
  int idkh;

  User_Pass({
    required this.userName,
    required this.passWork,
    required this.toKen,
    required this.idkh,
  });

  factory User_Pass.fromJson(Map<String, dynamic> json) => User_Pass(
        userName: json["userName"],
        passWork: json["passWork"],
        toKen: json["toKen"],
        idkh: json["idkh"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "passWork": passWork,
        "toKen": toKen,
        "idkh": idkh,
      };
}

User_Pass initAccount =
    User_Pass(userName: "", passWork: '', toKen: '', idkh: 0);
