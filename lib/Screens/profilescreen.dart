import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simpleprofilecreation/Providers/homescreenprovider.dart';

class Profilepage extends StatelessWidget {

  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Profile")),
        body: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.sp,
              ),
              Consumer<HomescreenProvider>(
                builder: (context, value, child) {
                  return GestureDetector(
                    onTap: () {
                      value.pickImage();
                    },
                    child: CircleAvatar(
                      radius: 55.r,
                      backgroundColor: Colors.blue,
                      backgroundImage: value.selectedimage != null ? FileImage(value.selectedimage!) : null,
                      child: value.selectedimage == null
                          ? const Icon(Icons.camera)
                          : null,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 40.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.sp),
                child: SizedBox(
                  height: 60.sp,
                  child: Consumer<HomescreenProvider>(
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: value.email,
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: "Enter Email",
                          errorText: value.erroremail,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.sp),
                child: SizedBox(
                  height: 60.sp,
                  child: Consumer<HomescreenProvider>(
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: value.password,
                        obscureText: value.ishidepass,
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: "Enter Password",
                          errorText: value.errorpassword,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              value.togglepass();
                            },
                            child: Icon(
                              value.ishidepass ? Icons.visibility : Icons.visibility_off,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 50.sp,
              ),
              Consumer<HomescreenProvider>(
                builder: (context, value, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 110.sp),
                    child: GestureDetector(
                      onTap:  () {
                        value.emailpassvalidator(value.email.text,value.password.text);
                        value.saveToSharedPreferences(value.email.text,value.password.text,value.selectedimage!.path).then((values) {
                          value.shoowsnackbar(values,context);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10.r)
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.sp,vertical: 15.sp),
                          child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 16.sp),),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
    );
  }
}
