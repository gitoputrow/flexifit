import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/widget/ButtonCustomMain.dart';

class WorkoutListPage extends GetView<DashboardController> {
  const WorkoutListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(10, 12, 13, 1),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                      child: Stack(
                        children: [
                          Image.network(
                            controller.workoutData.picture!,
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Container(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    "image_not_found",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromRGBO(170, 5, 27, 1),
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20, top: 30),
                            child: IconButton(
                              icon: Image.asset("asset/Image/backwo.png"),
                              iconSize: 40,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            "${controller.workoutData.title} Workout",
                            style: TextStyle(
                                fontFamily: 'RubikSemiBold', fontSize: 32, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "with ${controller.workoutData.data!.length} workouts",
                          style: TextStyle(
                              fontFamily: 'RubikLight', fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        for (int i = 0; i < controller.workoutData.data!.length; i++)
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 110,
                                    width: 110,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl : controller.workoutData.data![i].picture!,
                                        height: 110,
                                        width: 110,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) {
                                          return Container(
                                            color: Colors.white,
                                            child: Center(
                                              child: Text(
                                                "image_not_found",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        progressIndicatorBuilder: (context, url, progress) {
                                          
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: Color.fromRGBO(170, 5, 27, 1),
                                              value: progress.progress,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.workoutData.data![i].title!,
                                        style: TextStyle(
                                            fontFamily: 'RubikMedium',
                                            fontSize: 23,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "X ${controller.workoutData.reps}",
                                        style: TextStyle(
                                            fontFamily: 'RubikLight',
                                            fontSize: 21,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4),
                    child: ButtonCustomMain(
                        onPressed: () {
                          Get.toNamed("/workoutprepare");
                        },
                        alignText: Alignment.center,
                        borderRadius: 30,
                        colorText: Colors.white,
                        title: "Start",
                        primary: Color.fromARGB(255, 138, 4, 22),
                        permission: true)),
                SizedBox(
                  height: 25,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
