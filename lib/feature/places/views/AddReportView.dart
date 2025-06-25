import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:pain/feature/places/controllers/AddReportController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CustomButton.dart';
import 'package:pain/widget/CustomUploadMediaForm.dart';
import 'package:pain/widget/HeaderPageWidget.dart';
import 'package:pain/widget/TextFieldCustom.dart';

class AddReportsView extends GetView<AddReportController> {
  const AddReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: Get.context!.height -
                  Get.context!.mediaQueryViewPadding.top,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  HeaderPageWidget(text: "Add Report"),
                  SizedBox(height: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: FormBuilder(
                        key: controller.form,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: tertiaryColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: double.maxFinite,
                              padding: EdgeInsets.all(24),
                              child: Center(
                                child: Text(
                                  controller.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "PoppinsBoldSemi",
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            CustomUploadMediaForm(
                              name: "media",
                              label: "Media",
                              isMultipleUpload: true,
                              isRequired: true,
                            ),
                            SizedBox(height: 20),
                            TextFieldCustom(
                              label: "Description",
                              name: "desc",
                              maxLines: 5,
                              isRequired: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(16),
                              hintText: "Descripe the issue",
                              hintTextColor: tertiaryTextColor,
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ButtonCustomMain(
                      onPressed: () {
                        controller.submit();
                      },
                      title: "Submit",
                    ),
                  ),
                  SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
