import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EP_Page extends StatelessWidget {

  String id;
  EP_Page(this.id);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(47, 47, 47, 1),
        body: ScreenUtilInit(
          designSize: Size(423,897),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context,widget) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 29.h,left: 22.w,right: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 0.w),
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
                          padding: EdgeInsets.only(top: 9.h),
                          alignment: Alignment.center,
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontSize: 23.sp,
                                fontFamily: 'PoppinsBoldSemi',
                                color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                      child : Edit_Profile(id),
                    )

                  ],
                ),
              ),
            );
          },)
      ),);
  }
}

class Edit_Profile extends StatefulWidget {

  String id;
  Edit_Profile(this.id);

  @override
  _Edit_ProfileState createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {

  File? imageSource;
  String imagepath = "";
  bool isLoading = false;
  final storageRef = FirebaseStorage.instance.ref();

  uploadImage() async {
    if (imageSource != null){
      try {
        setState(() {
          isLoading = true;
        });
        await storageRef.child("PP_${widget.id}")
            .putFile(imageSource!).whenComplete(()
        => storageRef.child("PP_${widget.id}")
            .getDownloadURL().then((value){
          ref.child(widget.id).child("ProfilePic").set(value).whenComplete(() => setState(() {
            isLoading = false;
          }));
        }));
      } catch (e) {
        // ...
      }
    }
  }

  Future PickImage(ImageSource source) async{
    try{
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.imageSource = imageTemporary;
        this.imagepath = imageTemporary.path;
        pp_ = true;
      });
    }
    on PlatformException catch (e){

    }
  }

  String hintUser = "";
  String hintEmail = "";
  String hintName = "";
  String hintHeight = "";
  String hintWeight = "";
  String pp = "";
  String gender = "";

  String key = "";

  final textEmail = TextEditingController();
  final textUser = TextEditingController();
  final textName = TextEditingController();
  final textWeight = TextEditingController();
  final textHeight = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  updateEmail(String email) async {
    final user = await _auth.currentUser;
    String path = "email";
    user!.updateEmail(email).whenComplete(() =>
    changeData(path, email));
  }

  bool emailChecker = true;

  checkIfEmailInUse(String emailAddress) async {
    try {
      // Fetch sign-in methods for the email address
      final list = await _auth.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        setState(() {
          emailChecker = true;
        });
      } else {
        // Return false because email adress is not in use
        setState(() {
          emailChecker = false;
        });
      }
    } catch (error) {
      // Handle error
      // ...
      setState(() {
        emailChecker = true;
      });
    }
  }

  List user_list = [];

  database() async {
    final data = await ref.get();
    setState(() {
      for (var children in data.children){
        String user_ = children.child("user").value.toString();
        user_list.add(user_);
      }
      hintUser = data.child(widget.id).child("user").value.toString();
      hintName = data.child(widget.id).child("name").value.toString();
      hintEmail = data.child(widget.id).child("email").value.toString();
      hintHeight = data.child(widget.id).child("height").value.toString();
      hintWeight = data.child(widget.id).child("weight").value.toString();
      pp = data.child(widget.id).child("ProfilePic").value.toString();
      gender = data.child(widget.id).child("gender").value.toString();
    });
  }

  bool userError(String user){
    if(user.isNotEmpty && user.contains(" ")){
      return true;
    }
    else{
      return false;
    }
  }

  bool user = false;
  bool name = false;
  bool email = false;
  bool height = false;
  bool weight = false;
  bool gender_ = false;
  bool pp_ = false;

  bool cek(){
    if (user == false && email == false && name == false
        && height == false && weight == false && gender_ == false && pp_ == false){
      return false;
    }
    else{
      return true;
    }
  }
  bool emailError(email){
    if (emailValid(email) == false && email.toString().isNotEmpty){
      return true;
    }
    else{
      return false;
    }
  }
  bool emailValid(email){
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
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
          padding: EdgeInsets.only(top: 16.h),
          child: pp == "" ? Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(205, 5, 27, 1),
            ),
          ) : Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  child: CircleAvatar(
                    backgroundImage: imageSource == null ? Image.network(pp,fit: BoxFit.cover).image
                        : Image.file(imageSource!,fit: BoxFit.cover,).image,
                    radius: 60.h,
                  ),
                  radius: 60.h,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 90.w,top: 80.h),
                child: MaterialButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context){
                          return Container(
                            height: 130.h,
                            color: Color.fromRGBO(55, 55, 55, 1),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  child: Text(
                                    'Change Profile Picture',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily: 'RubikReguler',
                                        color: Colors.white
                                    ),),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 0.2.w),
                                      child: MaterialButton(
                                        onPressed: () {
                                          PickImage(ImageSource.camera);
                                          Navigator.of(context).pop();
                                        },
                                        color: Color.fromRGBO(
                                            180, 26, 17, 1.0),
                                        textColor: Colors.white,
                                        child: Icon(
                                          Icons.camera_alt_rounded,
                                          size: 32.h,
                                        ),
                                        padding: EdgeInsets.all(10.w),
                                        shape: CircleBorder(),
                                      ),
                                    ),
                                    Container(
                                      child: MaterialButton(
                                        onPressed: () {
                                          PickImage(ImageSource.gallery);
                                          Navigator.of(context).pop();
                                        },
                                        color: Color.fromRGBO(
                                            180, 26, 17, 1.0),
                                        textColor: Colors.white,
                                        child: Icon(
                                          Icons.image_rounded,
                                          size: 32.h,
                                        ),
                                        padding: EdgeInsets.all(10.w),
                                        shape: CircleBorder(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  },
                  color: Color.fromRGBO(
                      180, 26, 17, 1.0),
                  textColor: Colors.white,
                  child: Icon(
                    Icons.camera_alt_rounded,
                    size: 18.h,
                  ),
                  padding: EdgeInsets.all(10.w),
                  shape: CircleBorder(),
                ),
              ),
            ],
          ),
        ),

        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 16.h),
          child: Text(
            "Username",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'RubikLight',
                fontSize: 14.sp),
          ),
        ),
        Container(
          child: TextField(
            keyboardType: TextInputType.name,
            controller: textUser,
            onChanged: (text){
              if(textUser.text.isNotEmpty){
                setState(() {
                  user = true;
                });
              }
              else{
                setState(() {
                  user = false;
                });
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 6.w),
              hintText: hintUser,
              hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  fontFamily: 'RubikMedium',
                  fontSize: 18.sp),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              errorText: userError(textUser.text) == true ? "Username can't contain any space" : null,
            ),
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: 18.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 20.h),
          child: Text(
            "Email",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'RubikLight',
                fontSize: 14.sp),
          ),
        ),
        Container(
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: textEmail,
            onChanged: (text){
              if(textEmail.text.isNotEmpty){
                checkIfEmailInUse(textEmail.text.toString());
                setState(() {
                  email = true;
                });
              }
              else{
                setState(() {
                  email = false;
                });
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 6.w),
              hintText: hintEmail,
              hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  fontFamily: 'RubikMedium',
                  fontSize: 18.sp),
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
              errorText: emailError(textEmail.text) == true ? "your email is not valid" : null,
            ),
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: 18.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 20.h),
          child: Text(
            "Full Name",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'RubikLight',
                fontSize: 14.sp),
          ),
        ),
        Container(
          child: TextField(
            keyboardType: TextInputType.name,
            controller: textName,
            onChanged: (text){
              if(textName.text.isNotEmpty){
                setState(() {
                  name = true;
                });
              }
              else{
                setState(() {
                  name = false;
                });
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 6.w),
              hintText: hintName,
              hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  fontFamily: 'RubikMedium',
                  fontSize: 18.sp),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: 18.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 20.h),
          child: Text(
            "Height",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'RubikLight',
                fontSize: 14.sp),
          ),
        ),
        Container(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: textHeight,
            onChanged: (text){
              if(textHeight.text.isNotEmpty){
                setState(() {
                  height = true;
                });
              }
              else{
                setState(() {
                  height = false;
                });
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 6.w,top: 14.h),
              hintText: hintHeight,
              hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  fontFamily: 'RubikMedium',
                  fontSize: 18.sp),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              suffixIcon: Container(
                padding: EdgeInsets.only(left:3.w,top: 12.h),
                child: Text("cm",style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  fontSize: 18.sp,
                ),),
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
          padding: EdgeInsets.only(top: 20.h),
          child: Text(
            "Weight",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'RubikLight',
                fontSize: 14.sp),
          ),
        ),
        Container(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: textWeight,
            onChanged: (text){
              if(textWeight.text.isNotEmpty){
                setState(() {
                  weight = true;
                });
              }
              else{
                setState(() {
                  weight = false;
                });
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 6.w,top: 14.h),
              hintText: hintWeight,
              hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  fontFamily: 'RubikMedium',
                  fontSize: 18.sp),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              suffixIcon: Container(
                padding: EdgeInsets.only(left:9.w,top: 12.h),
                child: Text("kg",style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  fontSize: 18.sp,
                ),),
              ),
            ),
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: 18.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 20.h),
          child: Text(
            "Gender",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'RubikLight',
                fontSize: 14.sp),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: DropdownButton<String>(
            value: gender == "" ? "Male" : gender,
            items: <String>['Male', 'Female']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                      color: gender_ == false ? Color.fromRGBO(255, 255, 255, 0.5) : Color.fromRGBO(255, 255, 255, 0.8),
                      fontFamily: 'RubikMedium',
                      fontSize: 18.sp),
                ),
              );
            }).toList(),
            // Step 5.
            onChanged: (String? newValue) {
              setState(() {
                gender = newValue!;
                gender_ = true;
              });
            },
            dropdownColor: Color.fromRGBO(47, 47, 47, 1),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 35.h),
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
                          padding: EdgeInsets.only(right: 16.w),
                          child: ElevatedButton(onPressed: () {

                            textUser.text = "";
                            textEmail.text = "";
                            textName.text = "";
                            textHeight.text = "";
                            textWeight.text = "";

                          },
                            child: Text("Discard",style:
                            TextStyle(fontSize: 16.sp,
                                fontFamily: 'RubikMedium',
                                color: cek() == false ? Color.fromRGBO(255, 255, 255, 0.4) : Color.fromRGBO(255, 255, 255, 1) ),),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                padding: EdgeInsets.symmetric(vertical: 14.h,),
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
                          padding: EdgeInsets.only(left: 16.w),
                          child: ElevatedButton(onPressed: () {
                            if (cek() == true){
                              if (emailError(textEmail.text) == true || userError(textUser.text) == true){
                                Fluttertoast.showToast(
                                    msg: "Complete the Error Message",  // message
                                    toastLength: Toast.LENGTH_SHORT, // length
                                    gravity: ToastGravity.BOTTOM,    // location
                                    timeInSecForIosWeb: 1               // duration
                                );
                              }
                              else{
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
                                                              FirebaseAuth _auth = FirebaseAuth.instance;
                                                              if (textUser.text.isNotEmpty){
                                                                if (user_list.contains(textUser.text)){
                                                                  Fluttertoast.showToast(
                                                                      msg: "Username already in use",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIosWeb: 1);
                                                                }
                                                                else{
                                                                  changeData("user", textUser.text);
                                                                }
                                                              }
                                                              if (textName.text.isNotEmpty){
                                                                changeData("name", textName.text);
                                                              }
                                                              if (textHeight.text.isNotEmpty){
                                                                changeData("height", textHeight.text);
                                                              }
                                                              if (textWeight.text.isNotEmpty){
                                                                changeData("weight", textWeight.text);
                                                              }
                                                              if(emailValid(textEmail.text) == true){
                                                                if (checkIfEmailInUse(textEmail.text) == true){
                                                                  Fluttertoast.showToast(
                                                                      msg: "Username already in use",
                                                                      toastLength: Toast.LENGTH_SHORT,
                                                                      gravity: ToastGravity.BOTTOM,
                                                                      timeInSecForIosWeb: 1);
                                                                }
                                                                else{
                                                                  updateEmail(textEmail.text);
                                                                }
                                                              }
                                                              if(gender_ == true){
                                                                changeData("gender", gender);
                                                              }
                                                              if (pp_ == true){
                                                                uploadImage();
                                                              }
                                                              Navigator.of(context).pop();
                                                              Navigator.pop(context);
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
                                padding: EdgeInsets.symmetric(vertical: 14.h,),
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

