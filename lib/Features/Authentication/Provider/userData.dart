import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails extends ChangeNotifier{
  String _emailAddress='' ;
  String _name ='' ;
  String _age = '';
  String _sex = '';
  String _number = '';
  double _height = 0;
  double _weight = 0;
  String _password = '';

  String get name => _name;
  String get age => _age;
  String get sex => _sex;
  String get number => _number;
  double get height => _height;
  double get weight => _weight;


  String get emailAddress => _emailAddress;


  String get password => _password;
//to save the user data
  void saveUserData(
      {required String name,required String emailAddress,
        required String password,
        required String number,
        required String age,
        required String sex,
        required double height,
        required double weight}) {
    _emailAddress = emailAddress;
    _password = password;
    _number = number;
    _name=name;
    _sex = sex;
    _height = height;
    _weight = weight;
    _age = age;
    notifyListeners();
  }

  //to save the user data in local storege

  Future<void> saveUserDataLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', _name);
    prefs.setString('age', _age);
    prefs.setString('sex', _sex);
    prefs.setString('number', _number);
    prefs.setDouble('height', _height);
    prefs.setDouble('weight', _weight);
    prefs.setString('email', _emailAddress);
    prefs.setString('password', _password);
  }
//to load the user data
  Future<void> loadUserDataLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _name = prefs.getString('name') ?? '';
    _age = prefs.getString('age') ?? '';
    _sex = prefs.getString('sex') ?? '';
    _number = prefs.getString('number') ?? '';
    _height = prefs.getDouble('height') ?? 0;
    _weight = prefs.getDouble('weight') ?? 0;
    _emailAddress = prefs.getString('email') ?? '';
    _password = prefs.getString('password') ?? '';

    notifyListeners();
  }

}