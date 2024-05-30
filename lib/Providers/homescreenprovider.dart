import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomescreenProvider extends ChangeNotifier {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _showsnackbar = false;

  File? _selectedimage;
  String? _emailerror;
  String? _passerror;
  bool _hidepass = true;

  bool get showsnackbar => _showsnackbar;
  bool get ishidepass => _hidepass;
  File? get selectedimage => _selectedimage;
  String? get erroremail => _emailerror;
  String? get errorpassword => _passerror;

  TextEditingController get email => _email;
  TextEditingController get password => _password;

  void shoowsnackbar(bool value,BuildContext context) {
    _showsnackbar = value;
    if(_showsnackbar){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saved successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      _showsnackbar = false;
    }
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      imageQuality: 100,
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      XFile xfilePick = pickedFile;
      _selectedimage = File(xfilePick.path);
      notifyListeners();
    }
  }

  void emailpassvalidator(String email,String password) {
    if (email.isEmpty) {
      _emailerror = 'This field can not be empty';
    } else if (!email.endsWith('@gmail.com')) {
      _emailerror = 'Invalid email (must end with @gmail.com)';
    } else if (password.isEmpty) {
      _passerror = 'This field can not be empty';
    } else if(password.length < 6){
      _passerror = "Password length should be > 6";
    } else{
      _emailerror = null;
      _passerror = null;
    }
    notifyListeners();
  }

  void togglepass() {
    _hidepass = !_hidepass;
    notifyListeners();
  }

  Future<bool> saveToSharedPreferences(String email,String password, String imagepath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if ((email.isNotEmpty && email.endsWith('@gmail.com')) && password.isNotEmpty && password.length > 6 && _selectedimage != null) {
      prefs.setString('email', _email.text);
      prefs.setString('password', _password.text);
      prefs.setString('image_path', _selectedimage!.path);
      print("saved to sharepref");
      return true;
    } else {
      print('Fields cannot be null');
      return false;
    }

  }

  Future<void> loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? useremail = prefs.getString('email');
    String? userpass = prefs.getString('password');
    String? userimagepath = prefs.getString('image_path');

    if (useremail!.isNotEmpty && userpass!.isNotEmpty && userimagepath!.isNotEmpty) {

      _email.text = useremail;
      _password.text = userpass;
      _selectedimage = File(userimagepath);

      print("==${_email.text}\n===${_password.text}\n==$userimagepath=============");

    }
    notifyListeners();
  }

}