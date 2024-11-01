import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:pain/feature/social_media/controller/AddPostController.dart';

import '../../../controller/SosialMediaController.dart';
import '../../../widget/ButtonCustomMain.dart';

class AddPostPage extends GetView<AddPostController> {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(10, 12, 13, 1),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.top -
                MediaQuery.of(context).viewPadding.bottom,
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                    ),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Add New Post",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Image.file(controller.imageFile!)),
                ),
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(32)),
                        border: Border.all(color: Colors.white),
                        color: Colors.white),
                    child: TextField(
                      controller: controller.caption,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write a Caption...",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 0)),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(right: 36, left: 36, bottom: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 0, color: Colors.white, strokeAlign: 0),
                      borderRadius: BorderRadius.all(Radius.zero)),
                  child: ButtonCustomMain(
                      onPressed: () async {
                        await controller.uploadPost();
                      },
                      title: "Upload",
                      permission: true),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
