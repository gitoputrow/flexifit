import 'dart:developer';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pain/Main/ProfilePage/Setting.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Profile_Page extends StatefulWidget {

  String id;
  Profile_Page(this.id);

  @override
  _Profile_PageState createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {

  File? imageSource;
  String imagepath = "";

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  bool BM = false;
  bool BF = false;

  bool newbie = false;
  bool pro = false;
  bool master = false;

  bool chest = false;
  bool arm = false;
  bool legs = false;
  bool abs = false;
  String goal = "";
  String level = "";
  Map muscledata = {};

  bool change = false;

  List<String> Muscle = [];
  final storageRef = FirebaseStorage.instance.ref();

  Map imageFolder = {};

  uploadImage() async {
    if (imageSource != null){
      try {
        setState(() {
          isLoading = true;
        });
        await storageRef.child(widget.id)
            .child("pic$picFormat")
            .putFile(imageSource!).whenComplete(()
        => storageRef.child(widget.id)
            .child("pic$picFormat")
            .getDownloadURL().then((value){
              setState(() {
                imageFolder["date"] = date;
                imageFolder["day"] = day;
                imageFolder["url"] = value;
              });
              ref.child(widget.id).child("foto").child("pic$picFormat").set(imageFolder).whenComplete(() => setState(() {
                isLoading = false;
              }));
        }));
      } catch (e) {
        // ...
      }
    }
  }

  int picFormat = 0;
  bool picfolder = false;

  List<String> days_ = [];
  List<String> dates_ = [];
  List<String> url_ = [];

  database() async {
    final goals = await ref.child(widget.id).child("goal").get();
    final levels = await ref.child(widget.id).child("level").get();
    final child = await ref.child(widget.id).child("foto").get();
    setState(() {
      if (child.exists){
        picfolder = true;
        picFormat = child.children.length;
        for(var child_ in child.children){
          days_.add(child_.child("day").value.toString());
          dates_.add(child_.child("date").value.toString());
          url_.add(child_.child("url").value.toString());
        }
      }
      else{
        picFormat = 0;
      }
    });

    setState(() {
      goal = goals.value.toString();
      if (goals.value.toString() == "build muscle"){
        BM = true;
      }
      else if (goals.value.toString() == "burn fat"){
        BF = true;
      }
      level = levels.value.toString();
      if (levels.value.toString() == "new"){
        newbie = true;
      }
      else if (levels.value.toString() == "pro"){
        pro = true;
      }
      else if (levels.value.toString() == "master"){
        master = true;
      }
    });
    final data = await ref.child(widget.id).get();
    for (var muscle in data.child("Muscle").children){
      var muscletarget = muscle.value.toString();
      log(muscletarget);
      setState(() {
        Muscle.add(muscletarget);
      });
    }
    setState(() {
      if (Muscle.contains("Chest")){
        chest = true;
      }
      if (Muscle.contains("Arm")){
        arm = true;
      }
      if (Muscle.contains("Abs")){
        abs = true;
      }
      if (Muscle.contains("Legs")){
        legs = true;
      }
    });

  }

  Future PickImage(ImageSource source) async{
    try{
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.imageSource = imageTemporary;
        this.imagepath = imageTemporary.path;
        change = true;
      });
      notifikasi();
    }
    on PlatformException catch (e){

    }
  }

  notifikasi(){
    if (change == true){
      Fluttertoast.showToast(
          msg: "The save button is below",  // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM,    // location
          timeInSecForIosWeb: 1               // duration
      );
    }
  }

  String day = DateFormat('EEEE').format(DateTime.now()).toString();
  String date = DateFormat('d MMMM yyyy').format(DateTime.now()).toString();

  bool isLoading = false;

  @override
  void initState() {
    database();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(10, 12, 13, 1.0),
          body: ResponsiveSizer(builder: (BuildContext , Orientation , ScreenType ) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 7.5.w,top: 3.5.h,right: 7.5.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: Text(
                                  "Report",
                                  style: TextStyle(
                                      fontSize: 18.5.sp,
                                      fontFamily: 'PoppinsBoldSemi',
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 34.35.w,top: 0.4.h),
                                child: Divider(
                                  thickness: 0.3.h,
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 0.4.h),
                                child: Text(
                                  "My Progress",
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontFamily: 'PoppinsRegular',
                                      fontSize: 15.5.sp
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Image.asset("asset/Image/settingprofile.png"),
                            iconSize: 36,
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Setting_Page(widget.id)));
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 3.25.h),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "My Goals",
                        style: TextStyle(
                            fontSize: 18.5.sp,
                            fontFamily: 'RubikReguler',
                            color: Colors.white
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 2.8.h),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            if (BM == false){
                              BM = true;
                              BF = false;
                              goal = "build muscle";
                              change = true;
                            }
                          });
                          notifikasi();
                        },
                        child: Container(padding: EdgeInsets.only(left: 5.7.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: Text("Build Muscle",
                                  textAlign: TextAlign.left,
                                  style:
                                  TextStyle(
                                    fontFamily: 'RubikSemiBold',
                                    fontSize: 18.sp,
                                    color: BM == false ? Color.fromRGBO(255, 255, 255, 0.8) : Color.fromRGBO(255, 255, 255, 1),
                                  ),),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 0.6.h),
                                child: Text("Build mass & Strength",
                                  textAlign: TextAlign.left,
                                  style:
                                  TextStyle(
                                      fontFamily: 'RubikRegular',
                                      fontSize: 15.05.sp,
                                      color: BM == false ? Color.fromRGBO(255, 255, 255, 0.8) : Color.fromRGBO(255, 255, 255, 1)
                                  ),),
                              )

                            ],
                          ),),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            primary: BM == false ? Color.fromRGBO(255, 255, 255, 0.3) : Color.fromRGBO(205, 5, 27, 0.8),
                            padding: EdgeInsets.symmetric(vertical: 2.5.h)
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 2.8.h),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            if (BF == false){
                              BF = true;
                              BM = false;
                              goal = "burn fat";
                              change = true;
                            }
                          });
                          notifikasi();
                        },
                        child: Container(padding: EdgeInsets.only(left: 5.7.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: Text("Burn Fat",
                                  textAlign: TextAlign.left,
                                  style:
                                  TextStyle(
                                    fontFamily: 'RubikSemiBold',
                                    fontSize: 18.sp,
                                    color: BF == false ? Color.fromRGBO(255, 255, 255, 0.8) : Color.fromRGBO(255, 255, 255, 1),
                                  ),),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 0.6.h),
                                child: Text("Burn extra fat & Feel energized",
                                  textAlign: TextAlign.left,
                                  style:
                                  TextStyle(
                                    fontFamily: 'RubikRegular',
                                    fontSize: 15.05.sp,
                                    color: BF == false ? Color.fromRGBO(255, 255, 255, 0.8) : Color.fromRGBO(255, 255, 255, 1),
                                  ),),
                              )

                            ],
                          ),),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            primary: BF == false ? Color.fromRGBO(255, 255, 255, 0.3) : Color.fromRGBO(205, 5, 27, 0.8),
                            padding: EdgeInsets.symmetric(vertical: 2.5.h)
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 3.8.h),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "My Target Zones",
                        style: TextStyle(
                            fontSize: 18.5.sp,
                            fontFamily: 'RubikReguler',
                            color: Colors.white
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 2.8.h),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            change = true;
                            if (chest == false){
                              setState(() {
                                chest = true;
                                Muscle.add("Chest");
                              });
                            }
                            else{
                              setState(() {
                                chest = false;
                                Muscle.removeWhere((element) => element=="Chest");
                              });
                            }
                          });
                          notifikasi();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 5.7.w),
                          alignment: Alignment.centerLeft,
                          child: Text("Chest",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'RubikSemiBold',
                              fontSize: 18.sp,
                              color: chest == false ? Color.fromRGBO(255, 255, 255, 0.8) : Color.fromRGBO(255, 255, 255, 1),
                            ),),),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            primary: chest == false ? Color.fromRGBO(255, 255, 255, 0.3) : Color.fromRGBO(205, 5, 27, 0.8),
                            padding: EdgeInsets.symmetric(vertical: 2.95.h)
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 2.8.h),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            change = true;
                            if (arm == false){
                              setState(() {
                                arm = true;
                                Muscle.add("Arm");
                              });
                            }
                            else{
                              setState(() {
                                arm = false;
                                Muscle.removeWhere((element) => element=="Arm");
                              });
                            }
                          });
                          notifikasi();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 5.7.w),
                          alignment: Alignment.centerLeft,
                          child: Text("Arm",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'RubikSemiBold',
                              fontSize: 18.sp,
                              color: arm == false ? Color.fromRGBO(255, 255, 255, 0.8) : Color.fromRGBO(255, 255, 255, 1),
                            ),),),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            primary: arm == false ? Color.fromRGBO(255, 255, 255, 0.3) : Color.fromRGBO(205, 5, 27, 0.8),
                            padding: EdgeInsets.symmetric(vertical: 2.95.h)
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 2.8.h),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            change = true;
                            if (legs == false){
                              setState(() {
                                legs = true;
                                Muscle.add("Legs");
                              });
                            }
                            else{
                              setState(() {
                                legs = false;
                                Muscle.removeWhere((element) => element=="Legs");
                              });
                            }
                          });
                          notifikasi();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 5.7.w),
                          alignment: Alignment.centerLeft,
                          child: Text("Legs",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'RubikSemiBold',
                              fontSize: 18.sp,
                              color: legs == false ? Color.fromRGBO(255, 255, 255, 0.8) : Color.fromRGBO(255, 255, 255, 1),
                            ),),),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            primary: legs == false ? Color.fromRGBO(255, 255, 255, 0.3) : Color.fromRGBO(205, 5, 27, 0.8),
                            padding: EdgeInsets.symmetric(vertical: 2.95.h)
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 2.8.h),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            change = true;
                            if (abs == false){
                              setState(() {
                                abs = true;
                                Muscle.add("Abs");
                              });
                            }
                            else{
                              setState(() {
                                abs = false;
                                Muscle.removeWhere((element) => element=="Abs");
                              });
                            }
                          });
                          notifikasi();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 5.7.w),
                          alignment: Alignment.centerLeft,
                          child: Text("Abs",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'RubikSemiBold',
                              fontSize: 18.sp,
                              color: abs == false ? Color.fromRGBO(255, 255, 255, 0.8) : Color.fromRGBO(255, 255, 255, 1),
                            ),),),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            primary: abs == false ? Color.fromRGBO(255, 255, 255, 0.3) : Color.fromRGBO(205, 5, 27, 0.8),
                            padding: EdgeInsets.symmetric(vertical: 2.95.h)
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 3.25.h),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Workout Per Week",
                        style: TextStyle(
                            fontSize: 18.5.sp,
                            fontFamily: 'RubikReguler',
                            color: Colors.white
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 2.8.h),
                            child: ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  if (newbie == false){
                                    newbie = true;
                                    master = false;
                                    pro = false;
                                    level = "new";
                                    change = true;
                                  }
                                });
                                notifikasi();
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 0.w),
                                alignment: Alignment.centerLeft,
                                child: Text("3",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'RubikSemiBold',
                                    fontSize: 18.sp,
                                    color: newbie == false ? Color.fromRGBO(255, 255, 255, 0.8) : Color.fromRGBO(255, 255, 255, 1),
                                  ),),),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  primary: newbie == false ? Color.fromRGBO(255, 255, 255, 0.3) : Color.fromRGBO(205, 5, 27, 0.8),
                                  padding: EdgeInsets.symmetric(vertical: 2.95.h)
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.only(top: 2.8.h,left: 5.w),
                            child: ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  if (pro == false){
                                    pro = true;
                                    newbie = false;
                                    master = false;
                                    level = "pro";
                                    change = true;
                                  }
                                });
                                notifikasi();
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 0.w),
                                alignment: Alignment.centerLeft,
                                child: Text("4",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'RubikSemiBold',
                                    fontSize: 18.sp,
                                    color: pro == false ? Color.fromRGBO(255, 255, 255, 0.8) : Color.fromRGBO(255, 255, 255, 1),
                                  ),),),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  primary: pro == false ? Color.fromRGBO(255, 255, 255, 0.3) : Color.fromRGBO(205, 5, 27, 0.8),
                                  padding: EdgeInsets.symmetric(vertical: 2.95.h)
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.only(top: 2.8.h,left: 5.w),
                            child: ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  if (master == false){
                                    master = true;
                                    newbie = false;
                                    pro = false;
                                    level = "master";
                                    change = true;
                                  }
                                });
                                notifikasi();
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 0.w),
                                alignment: Alignment.centerLeft,
                                child: Text("5",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'RubikSemiBold',
                                    fontSize: 18.sp,
                                    color: master == false ? Color.fromRGBO(255, 255, 255, 0.8) : Color.fromRGBO(255, 255, 255, 1),
                                  ),),),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  primary: master == false ? Color.fromRGBO(255, 255, 255, 0.3) : Color.fromRGBO(205, 5, 27, 0.8),
                                  padding: EdgeInsets.symmetric(vertical: 2.95.h)
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 3.8.h,bottom: 2.8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "My Body",
                                style: TextStyle(
                                    fontSize: 18.5.sp,
                                    fontFamily: 'RubikReguler',
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Lihat Semua",
                                style: TextStyle(
                                    fontSize: 13.7.sp,
                                    fontFamily: 'RubikLight',
                                    color: Colors.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    if(picfolder == false)
                      Container(
                        height: 85.3.h,
                        child: isLoading == false ? Container(
                          padding: EdgeInsets.only(top: 2.8.h),
                          width: MediaQuery.of(context).size.width.w,
                          height: 85.3.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: imageSource == null ? Color.fromRGBO(255, 255, 255, 0.125) : null,
                              image: imageSource == null ? null : DecorationImage(
                                  image: FileImage(imageSource!),
                                  fit: BoxFit.cover
                              )
                          ),
                          child: imageSource == null ? IconButton(
                            icon: Image.asset("asset/Image/cameraImage.png",width: 18.w),
                            onPressed: (){
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context){
                                    return Container(
                                      height: 19.h,
                                      color: Color.fromRGBO(55, 55, 55, 1),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: 2.h),
                                            child: Text(
                                              'Add Picture',
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
                                                    size: 4.h,
                                                  ),
                                                  padding: EdgeInsets.all(16),
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
                                                    size: 4.h,
                                                  ),
                                                  padding: EdgeInsets.all(16),
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
                          ) : Container(
                            padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 6.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    day,
                                    style: TextStyle(
                                        fontSize: 23.sp,
                                        fontFamily: 'RubikSemiBold',
                                        color: Colors.white
                                    ),),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 1.5.h),
                                  child: Text(date,
                                    style: TextStyle(
                                        fontSize: 16.55.sp,
                                        fontFamily: 'RubikRegular',
                                        color: Colors.white
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ) :
                        Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(205, 5, 27, 1),
                          ),
                        ),
                      ),

                    if(picfolder == true)
                      Container(
                        height: 85.3.h,
                        padding: EdgeInsets.only(top: 3.h),
                        child: isLoading == false ? Container(
                            child: PageView(
                              controller: PageController(viewportFraction: 1,initialPage: 0),
                              padEnds: true,
                              children: [
                                Container(
                                  height: 85.3.h,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 2.8.h),
                                    width: MediaQuery.of(context).size.width.w,
                                    height: 85.3.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: imageSource == null ? Color.fromRGBO(255, 255, 255, 0.125) : null,
                                        image: imageSource == null ? null : DecorationImage(
                                            image: FileImage(imageSource!),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                    child: imageSource == null ? IconButton(
                                      icon: Image.asset("asset/Image/cameraImage.png",width: 18.w),
                                      onPressed: (){
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context){
                                              return Container(
                                                height: 19.h,
                                                color: Color.fromRGBO(55, 55, 55, 1),
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: 2.h),
                                                      child: Text(
                                                        'Add Picture',
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
                                                              size: 4.h,
                                                            ),
                                                            padding: EdgeInsets.all(16),
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
                                                              size: 4.h,
                                                            ),
                                                            padding: EdgeInsets.all(16),
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
                                    ) : Container(
                                      padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 6.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              day,
                                              style: TextStyle(
                                                  fontSize: 23.sp,
                                                  fontFamily: 'RubikSemiBold',
                                                  color: Colors.white
                                              ),),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 1.5.h),
                                            child: Text(date,
                                              style: TextStyle(
                                                  fontSize: 16.55.sp,
                                                  fontFamily: 'RubikRegular',
                                                  color: Colors.white
                                              ),),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ),
                                for(var i = 0; i < picFormat; i++)
                                  Container(
                                    child: carausel(dates_[i], days_[i], url_[i]),
                                  ),

                              ],
                            )
                        ) : Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(205, 5, 27, 1),
                          ),
                        ),
                      ),

                    if (change == true)
                      Container(
                          padding: EdgeInsets.only(top: 3.8.h),
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
                                            setState(() {
                                              arm = false;
                                              abs = false;
                                              chest = false;
                                              legs = false;
                                              BM = false;
                                              BF = false;
                                              database();
                                              imageSource = null;
                                              change = false;
                                            });
                                          },
                                            child: Text("Discard",style:
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
                                            if (Muscle.isEmpty){
                                              Fluttertoast.showToast(
                                                  msg: "You Have to Select The Target Zone",  // message
                                                  toastLength: Toast.LENGTH_SHORT, // length
                                                  gravity: ToastGravity.BOTTOM,    // location
                                                  timeInSecForIosWeb: 1               // duration
                                              );
                                            }
                                            else{
                                              uploadImage();
                                              ref.child(widget.id).child("goal").set(goal)
                                                  .whenComplete(() =>
                                                  ref.child(widget.id).child("Muscle").remove()
                                                      .whenComplete(() {
                                                    for (var i = 0; i < Muscle.length;i++){
                                                      muscledata["taget${i+1}"] = Muscle[i];
                                                    }
                                                    ref.child(widget.id).child("Muscle").set(muscledata);
                                                  })).whenComplete(() => 
                                              ref.child(widget.id).child("level").set(level)).whenComplete(() {
                                                setState(() {
                                                  change = false;
                                                });
                                              });
                                            }
                                          },
                                            child: Text("Save",style:
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
                            ],
                          )
                      )
                  ],
                ),
              ),
            );
          },)
        ));
  }
}

class carausel extends StatelessWidget {

  String dates = "";
  String days = "";
  String gambar = "";

  carausel(this.dates,this.days,this.gambar);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 0.w,left: 3.1.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
            image: NetworkImage(gambar),
            fit: BoxFit.cover
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text("$days",
                style: TextStyle(
                    fontSize: 23.sp,
                    fontFamily: 'RubikSemiBold',
                    color: Colors.white
                ),),
            ),
            Container(
              padding: EdgeInsets.only(top: 1.5.h),
              child: Text("$dates",
                style: TextStyle(
                    fontSize: 16.55.sp,
                    fontFamily: 'RubikRegular',
                    color: Colors.white
                ),),
            ),
          ],
        ),
      ),
    );
  }
}
