import 'package:flutter/material.dart';
import 'package:golden_net_app/domain/enteties/user.dart';

class UserModel {
  final String email;
  final String password;
  UserModel({@required this.email, @required this.password});
  UserModel.fromJson(Map<String, dynamic> json)
      : email= json['email'],
            password= json['password'];

  UserModel.fromUser(User user): email=user.email, password = user.password;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }

  User toUser() {
    return User(email: email, password: password);
  }
}
