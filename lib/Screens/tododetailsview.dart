import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tododetailsviewpage extends StatelessWidget {
  var todosdata;
  Tododetailsviewpage(this.todosdata);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo Details"),
      ),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("id : ${todosdata["id"]}"),
            SizedBox(height: 20.sp,),
            Text("todo : ${todosdata["todo"]}"),
            SizedBox(height: 20.sp,),
            Text("completed : ${todosdata["completed"]}"),
            SizedBox(height: 20.sp,),
            Text("userid : ${todosdata["userid"]}"),
          ],
        ),
      ),
    );
  }
}
