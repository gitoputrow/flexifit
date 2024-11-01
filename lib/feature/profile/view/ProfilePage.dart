import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pain/feature/profile/controller/ProfileController.dart';
import 'package:pain/feature/profile/view/widgets/MyProfilePage.dart';
import 'package:pain/feature/profile/view/widgets/MyProgramPage.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/widget/BottomSheetPicture.dart';
import 'package:pain/widget/CustomAlertDialog.dart';
import 'package:pain/widget/CustomRadioButton.dart';
import 'package:pain/widget/CustomRadioButtonCircle.dart';
import 'package:pain/widget/ProgramCard.dart';

import '../../../widget/ButtonCustomMain.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 12, 13, 1),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Profile",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 22, fontFamily: 'PoppinsBoldSemi', color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(right: MediaQuery.of(context).size.width / 2.7),
                              child: Divider(
                                thickness: 3,
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                            ),
                            Obx(() => DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    items: controller.items
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            )))
                                        .toList(),
                                    onChanged: (value) {
                                      controller.selectedValue = value as String;
                                    },
                                    value: controller.selectedValue,
                                    alignment: Alignment.centerLeft,
                                    buttonStyleData: ButtonStyleData(
                                      width: MediaQuery.of(context).size.width / 2.5
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(173, 5, 24, 1),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.white))
                                    ),
                                    selectedItemBuilder: ((context) {
                                      return controller.items
                                          .map((item) => DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(255, 255, 255, 1),
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 18),
                                                ),
                                              ))
                                          .toList();
                                    }),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Image.asset("asset/Image/settingprofile.png",width: 42,height: 42,),
                        
                        onPressed: () {
                          Get.toNamed("/settingpage", arguments: controller.user);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Obx(() =>
                      controller.selectedValue == "My Program" ? MyProgramPage() : MyProfilePage())
                  // Text(
                  //   "My Body",
                  //   style: TextStyle(fontSize: 22, fontFamily: 'RubikReguler', color: Colors.white),
                  // ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 25,
            // ),
            // SizedBox(
            //     height: MediaQuery.of(context).size.height / 1.47,
            //     width: MediaQuery.of(context).size.width,
            //     child: Obx(() {
            //       print(controller.userPhotoLength);
            //       return PageView(
            //         pageSnapping: true,
            //         padEnds: true,
            //         controller: PageController(viewportFraction: 0.87),
            //         children: [
            //           Container(
            //             padding: EdgeInsets.symmetric(horizontal: 15),
            //             child: ProgramCard(
            //               width: MediaQuery.of(context).size.width,
            //               height: MediaQuery.of(context).size.height / 1.47,
            //               imageUrl: null,
            //               days: controller.imageSource == null
            //                   ? ""
            //                   : DateFormat('EEEE').format(DateTime.now()).toString(),
            //               WorkoutName: controller.imageSource == null
            //                   ? ""
            //                   : DateFormat('d MMMM yyyy').format(DateTime.now()).toString(),
            //               imageSource: controller.imageSource,
            //               cameraTap: () {
            //                 Get.bottomSheet(BottomSheetPicture(pickImageCamera: () async {
            //                   await controller.PickImage(ImageSource.camera);
            //                 }, pickImageGallery: () {
            //                   controller.PickImage(ImageSource.gallery);
            //                 }));
            //               },
            //             ),
            //           ),
            //           if (controller.userPhotoLength != 0)
            //             for (var i = 0; i < controller.userPhotoLength; i++)
            //               Container(
            //                 padding: EdgeInsets.symmetric(horizontal: 15),
            //                 child: ProgramCard(
            //                   width: MediaQuery.of(context).size.width,
            //                   height: MediaQuery.of(context).size.height / 1.47,
            //                   imageUrl: controller.userPhoto[i].url,
            //                   days: controller.userPhoto[i].days!,
            //                   WorkoutName: controller.userPhoto[i].date!,
            //                 ),
            //               )
            //         ],
            //       );

            //     })),
            // SizedBox(
            //   height: 30,
            // ),
            // Obx(
            //   () => controller.imageSource == null
            //       ? SizedBox()
            //       : Container(
            //           padding: EdgeInsets.symmetric(horizontal: 30),
            //           child: Row(
            //             children: [
            //               Expanded(
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.stretch,
            //                   children: [
            //                     Obx(
            //                       () => ButtonCustomMain(
            //                           onPressed: () async {
            //                             Get.dialog(CustomAlertDialog(
            //                               backgroundColor: Color.fromRGBO(10, 12, 13, 0.8),
            //                               title: "Do you want to upload this picture?",
            //                               fontColor: Color.fromARGB(204, 255, 255, 255),
            //                               fontSize: 20,
            //                               iconColor: Colors.white,
            //                               onPressedno: (() {
            //                                 Get.back();
            //                                 controller.imageSource = null;
            //                               }),
            //                               onPressedyes: () async {
            //                                 Get.back();
            //                                 await controller.uploadImage();
            //                               },
            //                             ));
            //                           },
            //                           alignText: Alignment.center,
            //                           borderRadius: 15,
            //                           title: controller.test.value,
            //                           colorText: Colors.white,
            //                           primary: Color.fromRGBO(205, 5, 27, 0.8),
            //                           permission: true),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 35,
            //               ),
            //               Expanded(
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.stretch,
            //                   children: [
            //                     Obx(
            //                       () => ButtonCustomMain(
            //                           onPressed: () {
            //                             controller.imageSource = null;
            //                           },
            //                           alignText: Alignment.center,
            //                           borderRadius: 15,
            //                           colorText: Colors.black,
            //                           title: controller.testw.value,
            //                           primary: Color.fromRGBO(255, 255, 255, 1),
            //                           permission: true),
            //                     )
            //                   ],
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            // )
          ],
        ),
      ),
    );
  }
}
