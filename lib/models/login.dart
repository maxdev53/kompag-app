// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    Login({
        this.data,
    });

    Data data;

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.username,
        this.name,
        this.email,
        this.token,
        this.status,
        this.statusId,
        this.roleId,
        this.noHp,
        this.userRole,
    });

    int id;
    String username;
    String name;
    String email;
    String token;
    String status;
    int statusId;
    int roleId;
    dynamic noHp;
    String userRole;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        email: json["email"],
        token: json["token"],
        status: json["status"],
        statusId: json["status_id"],
        roleId: json["role_id"],
        noHp: json["no_hp"],
        userRole: json["userRole"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "email": email,
        "token": token,
        "status": status,
        "status_id": statusId,
        "role_id": roleId,
        "no_hp": noHp,
        "userRole": userRole,
    };
}
