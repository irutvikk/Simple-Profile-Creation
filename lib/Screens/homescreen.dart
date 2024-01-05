import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simpleprofilecreation/Providers/todosprovider.dart';
import 'package:simpleprofilecreation/Screens/profilescreen.dart';
import 'package:simpleprofilecreation/Screens/tododetailsview.dart';

import '../Providers/homescreenprovider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    HomescreenProvider homescreenProvider = Provider.of<HomescreenProvider>(context, listen: false);
    TodosProvider todosProvider = Provider.of<TodosProvider>(context, listen: false);
    homescreenProvider.initializeFromSharedPreferences();
    return Scaffold(
      backgroundColor: Colors.white,
            body: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  SizedBox(
                    height: 60.sp,
                    width: 1.sw,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.sp),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const Profilepage(),));
                              },
                              child: Consumer<HomescreenProvider>(
                                builder: (context, value, child) {
                                  return CircleAvatar(
                                    radius: 25.r,
                                    backgroundColor: Colors.blue,
                                    backgroundImage: value.selectedimage != null ? FileImage(value.selectedimage!) : null,
                                    child: value.selectedimage == null
                                        ? const Icon(Icons.camera)
                                        : null,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Align(alignment: Alignment.center,child: Text("Home",style: TextStyle(fontSize: 26.sp,fontWeight: FontWeight.bold),),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  FutureBuilder(
                    future: todosProvider.gettodosdata(),
                    builder: (context,  var snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Expanded(
                          child: Center(
                            child: CupertinoActivityIndicator(color: Colors.black,radius: 14.r),
                          ),
                        );
                      }  else {
                        return Expanded(
                          child: ScrollConfiguration(
                            behavior: const ScrollBehavior().copyWith(overscroll: false),
                            child: ListView.builder(
                              padding: EdgeInsets.all(0.sp),
                              shrinkWrap: true,
                              itemCount: todosProvider.todosdata["todos"].length,
                              itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(10.sp),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return Tododetailsviewpage(todosProvider.todosdata["todos"][index]);
                                    },));
                                  },
                                  child: Container(
                                    height: 80.sp,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10.r)
                                    ),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.sp),
                                      child: Text("${todosProvider.todosdata["todos"][index]["todo"]}"),
                                    ),
                                  ),
                                ),
                              );
                            },
                            ),
                          ),
                        );
                      }
                  },
                  )
                ],
              ),
            ),
          );
  }
}
