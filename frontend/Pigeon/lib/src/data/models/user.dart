import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  String phone;
  String chatId;

  User({
    @required this.id,
    @required this.name,
    @required this.phone,
    this.chatId,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    phone = json['phone'];
    chatId = json['chatId'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'phone': phone,
    };
  }

  User.fromLocalDatabaseMap(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toLocalDatabaseMap() {
    Map<String, dynamic> map = {};
    map['_id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    return map;
  }

  @override
  String toString() {
    return '{"_id":"$id","name":"$name","phone":"$phone"}';
  }
}
