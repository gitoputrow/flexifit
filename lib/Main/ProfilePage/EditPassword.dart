import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EPass_Page extends StatelessWidget {

  String id;
  EPass_Page(this.id);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (BuildContext , Orientation , ScreenType ) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(47, 47, 47, 1),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 3.25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5.5.w),
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Image.asset("asset/Image/backsetting.png"),
                          iconSize: 36,
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 1.1.h),
                        alignment: Alignment.center,
                        child: Text(
                          "Edit Password",
                          style: TextStyle(
                              fontSize: 18.5.sp,
                              fontFamily: 'PoppinsBoldSemi',
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                    child : Edit_Password(id),
                  )

                ],
              ),
            ),
          ),
        ),);
    },);
  }
}


class Edit_Password extends StatefulWidget {

  String id;
  Edit_Password(this.id);

  @override
  _Edit_PasswordState createState() => _Edit_PasswordState();
}

class _Edit_PasswordState extends State<Edit_Password> {

  final textOPass = TextEditingController();
  final textNPass = TextEditingController();
  final textCPass = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  updatePass(String pass) async {
    final user = await _auth.currentUser;
    String path = "pass";
    user!.updatePassword(pass).whenComplete(() =>
    changeData(path, pass));
  }

  String pass = "";

  database() async {
    final password = await ref.child(widget.id).child("pass").get();
    setState(() {
      pass = password.value.toString();
    });
  }

  bool opass = false;
  bool npass = false;
  bool cpass = false;

  bool opassvisible = false;
  bool npassvisible = false;
  bool cpassvisible = false;

  bool cek(){
    if (opass == false || npass == false || cpass == false){
      return false;
    }
    else{
      return true;
    }
  }


  changeData(String path,String value){
    ref.child(widget.id).child(path).set(value);
  }

  @override
  void initState() {
    database();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 2.8.h),
          child: Text(
            "Old Password",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'RubikLight',
                fontSize: 14.sp),
          ),
        ),
        Container(
          child: TextField(
            keyboardType: TextInputType.name,
            controller: textOPass,
            obscureText: opassvisible == false ? true : false,
            onChanged: (text){
              if(textOPass.text.isNotEmpty){
                opass = true;
              }
              else{
                opass = false;
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 2.w,top: 1.8.h),
              hintText: "Enter Old Password",
              hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  fontFamily: 'RubikMedium',
                  fontSize: 16.sp),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              suffixIcon: Container(
                padding: EdgeInsets.only(right: 2.w),
                child: IconButton(
                  icon: opassvisible == false ?
                  Image.asset("asset/Image/hidepass_Epass.png",width: 6.w,height: 6.h,) :
                  Image.asset("asset/Image/unhidepass_Epass.png",width: 24.w,height: 24.h,),
                  onPressed: () {
                    setState(() {
                      if (opassvisible == false) {
                        opassvisible = true;
                      }
                      else{
                        opassvisible = false;
                      }
                    });
                  },
                ),
              ),
            ),
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: 16.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 2.h),
          child: Text(
            "New Password",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'RubikLight',
                fontSize: 14.sp),
          ),
        ),
        Container(
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: textNPass,
            obscureText: npassvisible == false ? true : false,
            onChanged: (text){
              if(textNPass.text.isNotEmpty){
                npass = true;
              }
              else{
                npass = false;
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 2.w,top: 1.8.h),
              hintText: "Enter New Password",
              hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  fontFamily: 'RubikMedium',
                  fontSize: 16.sp),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.all(Radius.circular(16.0)),
              //   borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.9), width: 1.w),
              // ),
              suffixIcon: Container(
                padding: EdgeInsets.only(right: 2.w),
                child: IconButton(
                  icon: npassvisible == false ?
                  Image.asset("asset/Image/hidepass_Epass.png",width: 6.w,height: 6.h,) :
                  Image.asset("asset/Image/unhidepass_Epass.png",width: 24.w,height: 24.h,),
                  onPressed: () {
                    setState(() {
                      if (npassvisible == false) {
                        npassvisible = true;
                      }
                      else{
                        npassvisible = false;
                      }
                    });
                  },
                ),
              ),
              errorText: textNPass.text.length < 6 && textNPass.text.isNotEmpty ? "Your Password Must Be At Least 6 Character" : null,
            ),
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: 16.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 2.h),
          child: Text(
            "Confirm New Password",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'RubikLight',
                fontSize: 14.sp),
          ),
        ),
        Container(
          child: TextField(
            keyboardType: TextInputType.name,
            controller: textCPass,
            obscureText: cpassvisible == false ? true : false,
            onChanged: (text){
              if(textCPass.text.isNotEmpty){
                cpass = true;
              }
              else{
                cpass = false;
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 2.w,top: 1.8.h),
              hintText: "Enter Confirm New Password",
              hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  fontFamily: 'RubikMedium',
                  fontSize: 16.sp),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              suffixIcon: Container(
                padding: EdgeInsets.only(right: 2.w),
                child: IconButton(
                  icon: cpassvisible == false ?
                  Image.asset("asset/Image/hidepass_Epass.png",width: 6.w,height: 6.h,) :
                  Image.asset("asset/Image/unhidepass_Epass.png",width: 24.w,height: 24.h,),
                  onPressed: () {
                    setState(() {
                      if (cpassvisible == false) {
                        cpassvisible = true;
                      }
                      else{
                        cpassvisible = false;
                      }
                    });
                  },
                ),
              ),
              errorText: textCPass.text != textNPass.text && textCPass.text.isNotEmpty ? "Your Password Doesn't Match" : null,
            ),
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: 16.sp,
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 47.5.h),
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 4.w),
                            child: ElevatedButton(onPressed: () {

                              textNPass.text = "";
                              textOPass.text = "";
                              textCPass.text = "";

                            },
                              child: Text("Discard",style:
                              TextStyle(fontSize: 16.sp,
                                  fontFamily: 'RubikMedium',
                                  color: cek() == false ? Color.fromRGBO(255, 255, 255, 0.4) : Color.fromRGBO(255, 255, 255, 1) ),),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 1.8.h,),
                                  primary: cek() == false ? Color.fromRGBO(255, 255, 255, 0.1) : Color.fromRGBO(255, 255, 255, 0.3),
                                  onPrimary: Color.fromRGBO(0, 0, 0, 1.0)
                              ),),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 4.w),
                            child: ElevatedButton(onPressed: () {
                              if (cek() == true){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        backgroundColor: Color.fromRGBO(180, 180, 180, 1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8.w))),
                                        contentPadding: EdgeInsets.symmetric(vertical: 3.5.h,horizontal: 12.w),
                                        content: Container(
                                          // height: 15.h,
                                          width: 10.w,
                                          // decoration: BoxDecoration(
                                          //     // borderRadius: BorderRadius.circular(160),
                                          // ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Are You Sure Want",
                                                style: TextStyle(
                                                    fontFamily: "RubikRegular",
                                                    fontSize: 18.sp,
                                                    color: Color.fromRGBO(0, 0, 0, 0.8)
                                                ),),
                                              Text(
                                                "The Changes?",
                                                style: TextStyle(
                                                    fontFamily: "RubikRegular",
                                                    fontSize: 18.sp,
                                                    color: Color.fromRGBO(0, 0, 0, 0.8)
                                                ),),
                                              Container(
                                                padding: EdgeInsets.only(top: 2.h),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.only(right: 4.w),
                                                            child: ElevatedButton(onPressed: () {

                                                              Navigator.of(context).pop();

                                                            },
                                                              child: Text("No",style:
                                                              TextStyle(fontSize: 16.sp,
                                                                  fontFamily: 'RubikMedium',
                                                                  color: Colors.black  ),),
                                                              style: ElevatedButton.styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                  padding: EdgeInsets.symmetric(vertical: 1.8.h,),
                                                                  primary: Colors.white ,
                                                                  onPrimary: Color.fromRGBO(0, 0, 0, 1.0)
                                                              ),),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.only(left: 4.w),
                                                            child: ElevatedButton(onPressed: () {

                                                              if (cek() == true){
                                                                if (pass != textOPass.text){
                                                                  Fluttertoast.showToast(
                                                                      msg: "Wrong Password",  // message
                                                                      toastLength: Toast.LENGTH_SHORT, // length
                                                                      gravity: ToastGravity.BOTTOM,    // location
                                                                      timeInSecForIosWeb: 1               // duration
                                                                  );
                                                                }
                                                                else{
                                                                  if(textNPass.text.length < 6 || textCPass.text != textNPass.text){
                                                                    Fluttertoast.showToast(
                                                                        msg: "Complete the Error Message",  // message
                                                                        toastLength: Toast.LENGTH_SHORT, // length
                                                                        gravity: ToastGravity.BOTTOM,    // location
                                                                        timeInSecForIosWeb: 1               // duration
                                                                    );
                                                                  }
                                                                  else{
                                                                    updatePass(textNPass.text);
                                                                    Navigator.of(context).pop();
                                                                    Navigator.pop(context);
                                                                  }
                                                                }
                                                              }
                                                            },
                                                              child: Text("Yes",style:
                                                              TextStyle(fontSize: 16.sp,
                                                                  fontFamily: 'RubikMedium',
                                                                  color: Colors.white),),
                                                              style: ElevatedButton.styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                  padding: EdgeInsets.symmetric(vertical: 1.8.h,),
                                                                  primary: Color.fromRGBO(205, 5, 27, 0.8),
                                                                  onPrimary: Color.fromRGBO(0, 0, 0, 1.0)
                                                              ),),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                            },
                              child: Text("Save",style:
                              TextStyle(fontSize: 16.sp,
                                  fontFamily: 'RubikMedium',
                                  color: cek() == false ? Color.fromRGBO(0, 0, 0, 0.6) : Color.fromRGBO(0, 0, 0, 1)),),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 1.8.h,),
                                  primary: cek() == false ? Color.fromRGBO(255, 255, 255, 0.5) : Color.fromRGBO(255, 255, 255, 1),
                                  onPrimary: Color.fromRGBO(0, 0, 0, 1.0)
                              ),),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            )
        )
      ],
    );
  }
}

