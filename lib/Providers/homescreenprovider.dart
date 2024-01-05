import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomescreenProvider extends ChangeNotifier {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  File? _selectedimage;
  String? _emailerror;
  String? _passerror;
  bool _hidepass = true;
  bool _savingflag = false;

  bool get savingflag => _savingflag;
  bool get ishidepass => _hidepass;
  File? get selectedimage => _selectedimage;
  String? get erroremail => _emailerror;
  String? get errorpassword => _passerror;

  TextEditingController get email => _email;
  TextEditingController get password => _password;

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

  Future<void> saveToSharedPreferences(String email,String password, String imagepath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if ((email.isNotEmpty && email.endsWith('@gmail.com')) || password.isNotEmpty && password.length > 6 && _selectedimage != null) {
      prefs.setString('email', _email.text);
      prefs.setString('password', _password.text);
      prefs.setString('image_path', _selectedimage!.path);
      print("saved to sharepref");
    } else {
      print('Fields cannot be null');
    }
  }

  Future<void> initializeFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? useremail = prefs.getString('email');
    String? userpass = prefs.getString('password');
    String? userimagepath = prefs.getString('image_path');

    if (useremail!.isNotEmpty && userpass!.isNotEmpty && userimagepath!.isNotEmpty) {

      _email.text = useremail;
      _password.text = userpass;
      _selectedimage = File(userimagepath);

      print("==${_email.text}\n===${_password.text}\n==${userimagepath}=============");
    }
    notifyListeners();
  }

}