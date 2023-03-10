import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pain/Page/IntroPage/HomeScreen.dart';
import 'package:pain/Main/ProfilePage/EditProfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'ProfileInformation.dart';
import 'EditPassword.dart';


class Setting_Page extends StatefulWidget {

  String id;
  Setting_Page(this.id);

  @override
  _Setting_PageState createState() => _Setting_PageState();
}

class _Setting_PageState extends State<Setting_Page> {

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (BuildContext , Orientation , ScreenType ) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(47, 47, 47, 1),
          body: Container(
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
                        "Setting",
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
                  padding: EdgeInsets.only(top: 2.8.h,left: 7.5.w,right: 7.5.w,),
                  child: ElevatedButton(
                    onPressed: (){
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => EP_Page(widget.id)));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 7.w),
                      alignment: Alignment.centerLeft,
                      child: Text("Edit Profile",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'RubikMedium',
                            fontSize: 16.sp,
                            color: Color.fromRGBO(255, 255, 255, 1)
                        ),),),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        primary: Color.fromRGBO(255, 255, 255, 0.25),
                        padding: EdgeInsets.symmetric(vertical: 2.2.h)
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 2.8.h,left: 7.5.w,right: 7.5.w,),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => EPass_Page(widget.id)));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 7.w),
                      alignment: Alignment.centerLeft,
                      child: Text("Edit Password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'RubikMedium',
                            fontSize: 16.sp,
                            color: Color.fromRGBO(255, 255, 255, 1)
                        ),),),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        primary: Color.fromRGBO(255, 255, 255, 0.25),
                        padding: EdgeInsets.symmetric(vertical: 2.2.h)
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 2.8.h,left: 7.5.w,right: 7.5.w,),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => PI_Page(widget.id)));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 7.w),
                      alignment: Alignment.centerLeft,
                      child: Text("Profile Information",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'RubikMedium',
                            fontSize: 16.sp,
                            color: Color.fromRGBO(255, 255, 255, 1)
                        ),),),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        primary: Color.fromRGBO(255, 255, 255, 0.25),
                        padding: EdgeInsets.symmetric(vertical: 2.2.h)
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.only(top: 2.8.h,left: 7.5.w,right: 7.5.w,),
                //   child: ElevatedButton(
                //     onPressed: (){
                //
                //     },
                //     child: Container(
                //       padding: EdgeInsets.only(left: 7.w),
                //       alignment: Alignment.centerLeft,
                //       child: Text("About us",
                //         textAlign: TextAlign.left,
                //         style: TextStyle(
                //             fontFamily: 'RubikMedium',
                //             fontSize: 16.sp,
                //             color: Color.fromRGBO(255, 255, 255, 1)
                //         ),),),
                //     style: ElevatedButton.styleFrom(
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15)
                //         ),
                //         primary: Color.fromRGBO(255, 255, 255, 0.25),
                //         padding: EdgeInsets.symmetric(vertical: 2.2.h)
                //     ),
                //   ),
                // ),

                Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 4.9.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 2.8.h,left: 22.5.w,right: 22.5.w,),
                            child: ElevatedButton(
                              onPressed: (){

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
                                                "Are You Sure want",
                                                style: TextStyle(
                                                    fontFamily: "RubikRegular",
                                                    fontSize: 18.sp,
                                                    color: Color.fromRGBO(0, 0, 0, 0.8)
                                                ),),
                                              Text(
                                                "to Logout?",
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

                                                              FirebaseAuth _auth = FirebaseAuth.instance;
                                                              _auth.signOut();

                                                              Navigator.pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => HomeScreen()),
                                                                      (route) => false);

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
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(),
                                alignment: Alignment.center,
                                child: Text("Logout",
                                  style: TextStyle(
                                      fontFamily: 'RubikMedium',
                                      fontSize: 16.sp,
                                      color: Color.fromRGBO(255, 255, 255, 1)
                                  ),),),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                  ),
                                  primary: Color.fromRGBO(255, 255, 255, 0.1),
                                  padding: EdgeInsets.symmetric(vertical: 2.2.h)
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                )

              ],
            ),
          ),
        ),);
    },);
  }
}

