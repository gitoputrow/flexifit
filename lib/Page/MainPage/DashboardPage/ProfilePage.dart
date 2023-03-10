import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/widget/BottomSheetPicture.dart';
import 'package:pain/widget/CustomAlertDialog.dart';
import 'package:pain/widget/CustomRadioButton.dart';
import 'package:pain/widget/CustomRadioButtonCircle.dart';
import 'package:pain/widget/ProgramCard.dart';

import '../../../widget/ButtonCustomMain.dart';

class ProfilePage extends GetView<DashboardController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 12, 13, 1),
      body: SingleChildScrollView(
        controller: controller.scrollController.value,
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Report",
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
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "My Progress",
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Image.asset("asset/Image/settingprofile.png"),
                        iconSize: 42,
                        onPressed: () {
                          Get.toNamed("/settingpage", arguments: controller.user);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "My Goals",
                    style: TextStyle(fontSize: 22, fontFamily: 'RubikReguler', color: Colors.white),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Obx(
                    () => CustomRadioButton(
                      onPressed: () {
                        controller.changeData("goal", "build");
                      },
                      title: "Build Muscle",
                      fontSize: 21,
                      subText: Text(
                        'Build mass & Strength',
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'RubikRegular',
                            fontSize: 16,
                            color: controller.goalTemp == "build"
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(255, 255, 255, 0.8)),
                      ),
                      condition: controller.goalTemp != "build",
                      unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                      selectedText: Color.fromRGBO(255, 255, 255, 1),
                      unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                      selectedBut: Color.fromRGBO(205, 5, 27, 0.8),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => CustomRadioButton(
                        onPressed: () {
                          controller.changeData("goal", "burn");
                        },
                        title: "Burn Fat",
                        fontSize: 21,
                        subText: Text(
                          'Burn extra fat & Feel energized',
                          textScaleFactor: 1,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'RubikRegular',
                              fontSize: 16,
                              color: controller.goalTemp == "burn"
                                  ? Color.fromRGBO(255, 255, 255, 1)
                                  : Color.fromRGBO(255, 255, 255, 0.8)),
                        ),
                        condition: controller.goalTemp != "burn",
                        unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                        selectedText: Color.fromRGBO(255, 255, 255, 1),
                        unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                        selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "My Target Zones",
                    style: TextStyle(fontSize: 22, fontFamily: 'RubikReguler', color: Colors.white),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Obx(
                    () => CustomRadioButton(
                        onPressed: () {
                          controller.changeData("muscleTarget", "Abs");
                        },
                        fontSize: 22,
                        subText: null,
                        title: "Abs",
                        condition: !controller.muscleTemp.contains("Abs"),
                        unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                        selectedText: Color.fromRGBO(255, 255, 255, 1),
                        unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                        selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => CustomRadioButton(
                        onPressed: () {
                          controller.changeData("muscleTarget", "Arm's");
                        },
                        fontSize: 22,
                        subText: null,
                        title: "Arms",
                        condition: !controller.muscleTemp.contains("Arm's"),
                        unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                        selectedText: Color.fromRGBO(255, 255, 255, 1),
                        unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                        selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => CustomRadioButton(
                        onPressed: () {
                          controller.changeData("muscleTarget", "Chest");
                        },
                        fontSize: 22,
                        subText: null,
                        title: "Chest",
                        condition: !controller.muscleTemp.contains("Chest"),
                        unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                        selectedText: Color.fromRGBO(255, 255, 255, 1),
                        unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                        selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => CustomRadioButton(
                        onPressed: () {
                          controller.changeData("muscleTarget", "Leg's");
                        },
                        fontSize: 22,
                        subText: null,
                        title: "Legs",
                        condition: !controller.muscleTemp.contains("Leg's"),
                        unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                        selectedText: Color.fromRGBO(255, 255, 255, 1),
                        unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                        selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Workout Per Week",
                    style: TextStyle(fontSize: 22, fontFamily: 'RubikReguler', color: Colors.white),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Obx(
                        () => CustomRadioButtonCircle(
                            onPressed: () async {
                              controller.changeData("physic", "new");
                              await controller.getUserData();
                            },
                            title: "3",
                            condition: controller.physicTemp != "new",
                            unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                            selectedText: Color.fromRGBO(255, 255, 255, 1),
                            unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                            selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Obx(
                        () => CustomRadioButtonCircle(
                            onPressed: () {
                              controller.changeData("physic", "pro");

                              final x = DateFormat('dd/MM/y_H:mm:ss').format(DateTime.now());
                              print(x);
                              Timer.periodic(Duration(seconds: 2), (_) {
                                print(x);
                                _.cancel();
                              });
                            },
                            title: "4",
                            condition: controller.physicTemp != "pro",
                            unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                            selectedText: Color.fromRGBO(255, 255, 255, 1),
                            unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                            selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Obx(() => CustomRadioButtonCircle(
                          onPressed: () {
                            controller.changeData("physic", "master");
                          },
                          title: "5",
                          condition: controller.physicTemp != "master",
                          unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                          selectedText: Color.fromRGBO(255, 255, 255, 1),
                          unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                          selectedBut: Color.fromRGBO(205, 5, 27, 0.8)))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "My Body",
                    style: TextStyle(fontSize: 22, fontFamily: 'RubikReguler', color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height / 1.47,
                width: MediaQuery.of(context).size.width,
                child: Obx(() {
                  print(controller.userPhotoLength);
                  return PageView(
                    pageSnapping: true,
                    padEnds: true,
                    controller: PageController(viewportFraction: 0.87),
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ProgramCard(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.47,
                          imageUrl: null,
                          days: controller.imageSource == null
                              ? ""
                              : DateFormat('EEEE').format(DateTime.now()).toString(),
                          WorkoutName: controller.imageSource == null
                              ? ""
                              : DateFormat('d MMMM yyyy').format(DateTime.now()).toString(),
                          imageSource: controller.imageSource,
                          cameraTap: () {
                            Get.bottomSheet(BottomSheetPicture(pickImageCamera: () async {
                              await controller.PickImage(ImageSource.camera);
                            }, pickImageGallery: () {
                              controller.PickImage(ImageSource.gallery);
                            }));
                          },
                        ),
                      ),
                      if (controller.userPhotoLength != 0)
                        for (var i = 0; i < controller.userPhotoLength; i++)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: ProgramCard(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.47,
                              imageUrl: controller.userPhoto[i].url,
                              days: controller.userPhoto[i].days!,
                              WorkoutName: controller.userPhoto[i].date!,
                            ),
                          )
                    ],
                  );
                  
                })),
            SizedBox(
              height: 30,
            ),
            Obx(
              () => controller.imageSource == null
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Obx(
                                  () => ButtonCustomMain(
                                      onPressed: () async {
                                        Get.dialog(CustomAlertDialog(
                                          backgroundColor: Color.fromRGBO(10, 12, 13, 0.8),
                                          title: "Do you want to upload this picture?",
                                          fontColor: Color.fromARGB(204, 255, 255, 255),
                                          fontSize: 20,
                                          iconColor: Colors.white,
                                          onPressedno: (() {
                                            Get.back();
                                            controller.imageSource = null;
                                          }),
                                          onPressedyes: () async {
                                            Get.back();
                                            await controller.uploadImage();
                                          },
                                        ));
                                      },
                                      alignText: Alignment.center,
                                      borderRadius: 15,
                                      title: controller.test.value,
                                      colorText: Colors.white,
                                      primary: Color.fromRGBO(205, 5, 27, 0.8),
                                      permission: true),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 35,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Obx(
                                  () => ButtonCustomMain(
                                      onPressed: () {
                                        controller.imageSource = null;
                                      },
                                      alignText: Alignment.center,
                                      borderRadius: 15,
                                      colorText: Colors.black,
                                      title: controller.testw.value,
                                      primary: Color.fromRGBO(255, 255, 255, 1),
                                      permission: true),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
