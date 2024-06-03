import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tododetailsviewpage extends StatefulWidget {
  final todosdata;
  const Tododetailsviewpage({super.key, required this.todosdata});

  @override
  State<Tododetailsviewpage> createState() => _TododetailsviewpageState();
}

class _TododetailsviewpageState extends State<Tododetailsviewpage> {

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
            if (1 == 1)
              const Center(
                child: CircularProgressIndicator(color: Colors.black),
              ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () async {
                
                dynamic j;
                dynamic k = await compute(heavyTask, j);
                print(k['status']);
                // await heavyTask(100000000000);
                print("completed task");

              },
              child: const Text("Click to Compute"),
            ),
            Text("id : ${widget.todosdata["id"]}"),
            SizedBox(
              height: 20.sp,
            ),
            Text("todo : ${widget.todosdata["todo"]}"),
            SizedBox(
              height: 20.sp,
            ),
            Text("completed : ${widget.todosdata["completed"]}"),
            SizedBox(
              height: 20.sp,
            ),
            Text("userid : ${widget.todosdata["userId"]}"),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> heavyTask(dynamic k) async {
  double l = 20;
  for (int i = 0; i <= 1000000000; i++) {
    l = i + l;
  }
  return {"status": true};
}
