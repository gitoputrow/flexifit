import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/feature/settings/controller/EditProfileController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/HeaderPageWidget.dart';
import 'package:pain/widget/ProfilePictureDisplayWidget.dart';
import 'package:pain/widget/ShimmerLoading.dart';
import 'package:pain/widget/TextFieldCustom.dart';
import 'package:shimmer/shimmer.dart';
import '../../../widget/MediaWidget.dart';
import '../../../widget/CustomButton.dart';
import '../../../widget/TextFieldSettingCustom.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SafeArea(
                  child: SizedBox(
                    height: 28,
                  ),
                ),
                HeaderPageWidget(
                  text: "Edit Profile",
                  padding: EdgeInsets.zero,
                ),
                SizedBox(
                  height: 28,
                ),
                Obx(() => ProfilePictureDisplayWidget(
                      data: controller.user,
                      onEdit: () {
                        Get.bottomSheet(
                            BottomSheetMedia(pickImageCamera: () async {
                          await controller.pickImage(ImageSource.camera);
                        }, pickImageGallery: () {
                          controller.pickImage(ImageSource.gallery);
                        }));
                      },
                      tempFile: controller.imageSource,
                    )),
                SizedBox(
                  height: 28,
                ),
                Obx(() {
                  final data = controller.user;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldCustom(
                          name: "Username",
                          label: "Username",
                          fillColor: Colors.transparent,
                          borderColorEnabled: secondaryColor,
                          textColor: Colors.white,
                          borderColorFocused: primaryColor,
                          contentPadding: EdgeInsets.all(20),
                          onChanged: (text) {
                            controller.buttonPermissionEP();
                          },
                          keyboardType: TextInputType.text,
                          hintText: "${data?.username}",
                          textController: controller.username),
                      SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          name: "name",
                          label: "Name",
                          keyboardType: TextInputType.name,
                          fillColor: Colors.transparent,
                          borderColorEnabled: secondaryColor,
                          borderColorFocused: primaryColor,
                          textColor: Colors.white,
                          contentPadding: EdgeInsets.all(20),
                          onChanged: (text) {
                            controller.buttonPermissionEP();
                          },
                          hintText: "${controller.user?.name}",
                          textController: controller.name),
                      SizedBox(
                        height: 30,
                      ),
                      Obx(() => TextFieldCustom(
                          name: "height",
                          label: "Height",
                          keyboardType: TextInputType.number,
                          fillColor: Colors.transparent,
                          borderColorEnabled: secondaryColor,
                          borderColorFocused: primaryColor,
                          textColor: Colors.white,
                          contentPadding: EdgeInsets.all(20),
                          onChanged: (text) {
                            controller.buttonPermissionEP();
                          },
                          suffixIcon: Container(
                            padding: EdgeInsets.only(right: 0, top: 12),
                            child: Text(
                              "Cm",
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                  fontSize: 21),
                            ),
                          ),
                          hintText: "${controller.user?.height}",
                          textController: controller.height)),
                      SizedBox(
                        height: 30,
                      ),
                      Obx(() => TextFieldCustom(
                          name: "weight",
                          label: "Weight",
                          keyboardType: TextInputType.number,
                          fillColor: Colors.transparent,
                          borderColorEnabled: secondaryColor,
                          borderColorFocused: primaryColor,
                          contentPadding: EdgeInsets.all(20),
                          textColor: Colors.white,
                          onChanged: (text) {
                            controller.buttonPermissionEP();
                          },
                          suffixIcon: Container(
                            padding: EdgeInsets.only(left: 6, top: 12),
                            child: Text(
                              "Kg",
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                  fontSize: 21),
                            ),
                          ),
                          hintText: "${controller.user?.weight}",
                          textController: controller.weight)),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Gender",
                        style: TextStyle(
                            fontFamily: "PoppinsBoldSemi",
                            color: Colors.white,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Obx(() => DropdownButtonHideUnderline(
                            child: ShimmerLoading(
                              isLoading: data == null,
                              child: DropdownButton2(
                                items: controller.items
                                    .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (value) {
                                  controller.selectedValue = value as String;
                                  controller.buttonPermissionEP();
                                },
                                buttonStyleData: ButtonStyleData(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: secondaryColor,
                                        ))),
                                value: controller.selectedValue,
                                selectedItemBuilder: ((context) {
                                  return controller.items
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          )))
                                      .toList();
                                }),
                              ),
                            ),
                          ))
                    ],
                  );
                }),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Obx(
                            () => ButtonCustomMain(
                                onPressed: () {
                                  if (controller.buttonPermEP == true) {
                                    controller.discardEP();
                                    controller.imageSource = null;
                                    controller.buttonPermissionEP();
                                  }
                                },
                                alignText: Alignment.center,
                                borderRadius: 15,
                                title: "Discard",
                                colorTextFalse:
                                    Color.fromRGBO(255, 255, 255, 0.4),
                                primaryFalse:
                                    Color.fromRGBO(255, 255, 255, 0.1),
                                colorText: Colors.white,
                                primary: Color.fromRGBO(255, 255, 255, 0.3),
                                permission: controller.buttonPermEP),
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
                                  if (controller.buttonPermEP == true) {
                                    controller.changeProfile();
                                  }
                                },
                                alignText: Alignment.center,
                                borderRadius: 15,
                                colorText: Colors.white,
                                title: "Save",
                                colorTextFalse: disabledTextColor,
                                primaryFalse: buttonDiabledColor,
                                primary: primaryColor,
                                permission: controller.buttonPermEP),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 28,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
