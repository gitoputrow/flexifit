import 'dart:developer';
import 'dart:ffi';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PI_Page extends StatefulWidget {

  String id;
  PI_Page(this.id);

  @override
  _PI_PageState createState() => _PI_PageState();
}

class _PI_PageState extends State<PI_Page> {

  String key = "";
  String username = "";
  String fullname = "";
  String gender = "";
  String height = "";
  String weight = "";
  String age = "";
  String pp = "";

  List challangeName = [
    "Abs",
    "Biceps",
    "Cardio",
    "Chest",
    "Full Body",
    "Legs",
    "Triceps"
  ];

  List challangeData = [];

  double BMI = 0;
  double minW = 0;
  double maxW = 0;

  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  database() async {
    final data = await ref.child(widget.id).get();
    setState(() {
      username = data.child("user").value.toString();
      fullname = data.child("name").value.toString();
      gender = data.child("gender").value.toString();
      height = data.child("height").value.toString();
      weight = data.child("weight").value.toString();
      age = data.child("age").value.toString();
      pp = data.child("ProfilePic").value.toString();
      for (var child_ in data.child("Challange").children){
        log(child_.key.toString());
        challangeData.add(child_.value.toString());
      }
    });
    calculatorBMI();
  }

  calculatorBMI(){
    setState(() {
      BMI = (double.parse(weight) / math.pow((double.parse(height) / 100),2)) as double;
      minW = 18.5 * math.pow((double.parse(height) / 100),2);
      maxW = 25.0 * math.pow((double.parse(height) / 100),2);
      if (BMI < 18.5){
        BMI_res = "underweight";
      }
      else if (BMI > 18.5 && BMI < 25.0){
        BMI_res = "normal";
      }
      else if (BMI > 25.0 && BMI < 30.0){
        BMI_res = "overweight";
      }
      else{
        BMI_res = "obesity";
      }
    });
  }

  String BMI_res = "";

  @override
  void initState() {
    database();
    // TODO: implement initState
    super.initState();
  }

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
                          "$username",
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
                    child : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                child: CircleAvatar(
                                  backgroundImage: pp == "" ?
                                  Image.asset("asset/Image/profilepageIconActive.png",fit: BoxFit.cover,).image
                                      :Image.network(pp,fit: BoxFit.cover).image,
                                  radius: 4.h,
                                ),
                                radius: 4.h,
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(),
                                    child: Text(
                                      "Height",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'RubikReguler',
                                          fontSize: 17.5.sp),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 1.h),
                                    child: Text(
                                      "$height cm",
                                      style: TextStyle(
                                          color: Color.fromRGBO(248, 46, 15, 1.0),
                                          fontFamily: 'RubikSemiBold',
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(),
                                    child: Text(
                                      "Weight",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'RubikReguler',
                                          fontSize: 17.5.sp),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 1.h),
                                    child: Text(
                                      "$weight kg",
                                      style: TextStyle(
                                          color: Color.fromRGBO(248, 46, 15, 1.0),
                                          fontFamily: 'RubikSemiBold',
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(),
                                    child: Text(
                                      "Age",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'RubikReguler',
                                          fontSize: 17.5.sp),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 1.h),
                                    child: Text(
                                      "$age years",
                                      style: TextStyle(
                                          color: Color.fromRGBO(248, 46, 15, 1.0),
                                          fontFamily: 'RubikSemiBold',
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 2.h),
                          child: Text(
                            "Body Information",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'RubikReguler',
                                fontSize: 16.5.sp),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 0.5.h),
                          child: Divider(
                            color: Color.fromRGBO(248, 46, 15, 1.0),
                          )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BI_Widget("Full Name","$fullname"),
                                BI_Widget("Gender","$gender"),
                                BI_Widget("BMI","${BMI.toStringAsFixed(1)}"),
                                BI_Widget("Ideal Weight","${minW.toStringAsFixed(1)} kg - ${maxW.toStringAsFixed(1)} kg"),
                              ],
                            ),
                            Container(
                              child: BMI_res == "" ? null : Image.asset(
                                "asset/Image/Stamp/$BMI_res.png",
                                width: 45.w,
                              height: 22.h,),
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 2.h),
                          child: Text(
                            "Challange Progress",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'RubikReguler',
                                fontSize: 16.5.sp),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 0.5.h),
                            child: Divider(
                              color: Color.fromRGBO(248, 46, 15, 1.0),
                            )
                        ),
                        if (challangeData.isNotEmpty)
                          for (int i = 0; i < challangeName.length; i++)
                            Challange_widget(challangeName[i], challangeData[i*2], challangeData[i*2+1]),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 2.h),
                          child: Text(
                            "Photo",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'RubikReguler',
                                fontSize: 16.5.sp),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 0.5.h),
                            child: Divider(
                              color: Color.fromRGBO(248, 46, 15, 1.0),
                            )
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 3.h,top: 2.h),
                          child: ElevatedButton(onPressed: () {

                          },
                            child: Text("View All Photo",style:
                            TextStyle(fontSize: 16.sp,
                                fontFamily: 'RubikMedium',
                                color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.w)
                                ),
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                primary: Color.fromRGBO(170, 5, 27, 1),
                                onPrimary: Color.fromRGBO(0, 0, 0, 1.0)
                            ),),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),);
    },);
  }
}

class Challange_widget extends StatelessWidget {
  String ChallangeName = "";
  String FinishedBeg = "";
  String FinishedInter = "";

  Challange_widget(this.ChallangeName,this.FinishedBeg,this.FinishedInter);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(bottom: 0.5.h,top: 0.5.h),
          child: Text(
            "$ChallangeName",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'RubikReguler',
                fontSize: 16.sp),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(bottom: 0.5.h),
          child: RichText(
            text: TextSpan(
                text: "Beginner : ",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RubikLight',
                    fontSize: 15.sp),
                children: <TextSpan>[
                  TextSpan(
                    text: "$FinishedBeg finished",
                    style: TextStyle(
                        color: Color.fromRGBO(248, 46, 15, 1.0),
                        fontFamily: 'RubikLight',
                        fontSize: 15.sp),
                  ),
                ]
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(bottom: 0.5.h),
          child: RichText(
            text: TextSpan(
                text: "Intermediate : ",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RubikLight',
                    fontSize: 15.sp),
                children: <TextSpan>[
                  TextSpan(
                    text: "$FinishedInter finished",
                    style: TextStyle(
                        color: Color.fromRGBO(248, 46, 15, 1.0),
                        fontFamily: 'RubikLight',
                        fontSize: 15.sp),
                  ),
                ]
            ),
          ),
        ),
      ],
    );
  }
}

class BI_Widget extends StatelessWidget {

  String title = "";
  String result = "";

  BI_Widget(this.title,this.result);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(bottom: 0.5.h,top: 0.5.h),
          child: Text(
            "$title",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'RubikReguler',
                fontSize: 16.sp),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(bottom: 0.5.h),
          child: Text(
            "$result",
            style: TextStyle(
                color: Color.fromRGBO(248, 46, 15, 1.0),
                fontFamily: 'RubikLight',
                fontSize: 15.sp),
          ),
        ),
      ],
    );
  }
}



