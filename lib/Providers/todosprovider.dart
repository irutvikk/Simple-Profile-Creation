import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TodosProvider extends ChangeNotifier{
  bool isLoading = true;
  var todosdata;

  Future<void> gettodosdata() async {
    try{
      var url = Uri.parse("https://dummyjson.com/todos");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        todosdata = jsonDecode(response.body);
        print("response received");
        isLoading = false;
      }
    }catch(e){
      print("==something on provider==$e");
      await gettodosdata();
    }
    notifyListeners();
  }
}