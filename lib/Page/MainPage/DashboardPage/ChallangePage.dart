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
              for (var i = 0; i < controller.challangeData.length; i++)
                Obx(() => Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            controller.challangeIndex = i;
                            await controller.getFinishedData();
                            Get.toNamed("/challangelevel",arguments: [controller.finishedChallange,controller.workoutData,controller.challangeIndex,controller.challangeData]);
                          },
                          child: ChallangeCard(
                              height: 125,
                              title: controller.challangeData[i].title!,
                              picture: controller.challangeData[i].picture!,
                              width: MediaQuery.of(context).size.width),
                        ),
                        SizedBox(
                          height: 35,
                        )
                      ],
                    )),

              // SizedBox(
              //   height: 125,
              //   width: MediaQuery.of(context).size.width,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(20),
              //     child: Stack(
              //       children: [
              //         Image.asset(
              //           "asset/Image/Challange/Abschallange.png",
              //           fit: BoxFit.cover,
              //           width: MediaQuery.of(context).size.width,
              //           height: 125,
              //         ),
              //         Container(
              //           padding: EdgeInsets.only(bottom: 28, left: 31),
              //           alignment: Alignment.bottomLeft,
              //           child: Text(
              //             "Abs Workouts",
              //             style: TextStyle(
              //                 color: Colors.white, fontFamily: 'RubikReguler', fontSize: 22.5),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // )
              // Obx(
              //   () => SizedBox(
              //     height: MediaQuery.of(context).size.height,
              //     width: MediaQuery.of(context).size.width,
              //     child: ListView.separated(
              //         separatorBuilder: (context, index) {
              //           return SizedBox(
              //             height: 30,
              //           );
              //         },
              //         itemBuilder: (context, index) {
              //           return ChallangeCard(
              //               height: 125,
              //               title: controller.challangeData[index].title!,
              //               picture: controller.challangeData[index].picture!,
              //               width: MediaQuery.of(context).size.width);
              //         },
              //         scrollDirection: Axis.vertical,
              //         itemCount: controller.challangeData.length),
              //   ),
              // )
            ]),
          ),
        ),
      ),
    );
  }
}
