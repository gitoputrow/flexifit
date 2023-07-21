import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/widget/BasicLoader.dart';
import 'package:pain/widget/ChallangeCard.dart';

class ChallangePage extends GetView<DashboardController> {
  const ChallangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(10, 12, 13, 1),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Workouts From Home",
                style: TextStyle(fontSize: 21, fontFamily: 'PoppinsBoldSemi', color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                endIndent: MediaQuery.of(context).size.width / 1.95,
                thickness: 2,
                color: Color.fromRGBO(255, 255, 255, 0.5),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "All Workouts Challenge",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'PoppinsRegular',
                    fontSize: 15),
              ),
              SizedBox(
                height: 30,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => Obx(
                        () => GestureDetector(
                          onTap: () async {
                            controller.challangeIndex = index;
                            await controller.getFinishedData();
                            Get.toNamed("/challangelevel", arguments: [
                              controller.finishedChallange,
                              controller.workoutData,
                              controller.challangeIndex,
                              controller.challangeData
                            ]);
                          },
                          child: ChallangeCard(
                              height: 125,
                              challangeData: controller.challangeData[index],
                              width: MediaQuery.of(context).size.width),
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 35,
                      ),
                  itemCount: controller.challangeData.length)
            ]),
          ),
        ),
      ),
    );
  }
}
