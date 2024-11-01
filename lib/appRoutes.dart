import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pain/feature/authentification/controller/RegisterController.dart';
import 'package:pain/feature/places/controllers/PlacesController.dart';
import 'package:pain/feature/places/controllers/PlacesDetailController.dart';
import 'package:pain/feature/places/views/PlacesDetailPageView.dart';
import 'package:pain/feature/profile/controller/ProfileController.dart';
import 'package:pain/feature/social_media/controller/AddPostController.dart';
import 'package:pain/feature/social_media/controller/SocialMediaController.dart';
import 'package:pain/feature/workout/controller/WorkoutListController.dart';
import 'package:pain/feature/workout/controller/WorkoutProgressController.dart';
import 'package:pain/feature/workout/view/WorkoutFinishPage.dart';
import 'package:pain/feature/workout/view/WorkoutRestPage.dart';
import 'package:pain/feature/workout/view/WorkoutStartPage.dart';
import 'package:pain/feature/workout_challange/controller/WorkoutChallangeController.dart';
import 'package:pain/feature/workout_challange/controller/WorkoutChallangeDetailController.dart';
import 'package:pain/feature/workout_program/controller/WorkoutProgramController.dart';
import 'package:pain/page/IntroPage/splashscreen.dart';
import 'package:pain/page/MainPage/MainPage.dart';
import 'package:pain/feature/social_media/view/SosmedPage.dart';
import 'package:pain/page/MainPage/SettingPage/EditPasswordPage.dart';
import 'package:pain/page/MainPage/SettingPage/EditProfilePage.dart';
import 'package:pain/page/MainPage/SettingPage/SettingPage.dart';
import 'package:pain/feature/social_media/view/AddPostPage.dart';
import 'package:pain/feature/workout_challange/view/ChallangeLevelPage.dart';
import 'package:pain/feature/workout/view/WorkoutPreparePage.dart';
import 'package:pain/feature/authentification/view/RegisterPage.dart';
import 'package:pain/binding/AuthentificationBinding.dart';
import 'package:pain/binding/DashboardBinding.dart';

import 'feature/authentification/controller/LoginController.dart';
import 'feature/authentification/view/LoginPage.dart';
import 'feature/workout/view/WorkoutListPage.dart';
import 'feature/social_media/view/DetailPostPage.dart';
import 'page/MainPage/SosmedPage/ProfilePostPage.dart';
import 'binding/SettingBinding.dart';
import 'binding/SosialMediaBinding.dart';

class appRoutes {
  static final pages = <GetPage>[
    GetPage(
      name: "/splashscreen",
      page: () => SplashScreen(),
    ),
    GetPage(
      name: "/login",
      page: () => LoginPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => LoginController(),
        ),
      ),
    ),
    GetPage(
      name: "/regist",
      page: () => RegisterPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => RegisterController(),
        ),
      ),
    ),
    GetPage(
        name: "/dashboard",
        page: () => MainPage(),
        binding: DashboardBinding()),
    GetPage(
        name: "/challangelevel",
        page: () => ChallangeLevelPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => WorkoutChallangeDetailController(),
          ),
        )),
    GetPage(
        name: "/workoutlist",
        page: () => WorkoutListPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => WorkoutListController(),
          ),
        )),
    GetPage(
        name: "/workoutstart",
        page: () => WorkoutStartPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => WorkoutProgressController(),
          ),
        )),
    GetPage(
        name: "/workoutrest",
        page: () => WorkoutRestPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => WorkoutProgressController(),
          ),
        )),
    GetPage(
        name: "/workoutfinish",
        page: () => WorkoutFinishPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => WorkoutProgressController(),
          ),
        )),
    GetPage(
      name: "/workoutprepare",
      page: () => WorkoutPreparePage(),
    ),
    GetPage(
        name: "/settingpage",
        page: () => SettingPage(),
        binding: SettingBinding()),
    GetPage(
        name: "/editprofilepage",
        page: () => EditProfilePage(),
        binding: SettingBinding()),
    GetPage(
        name: "/editpasswordpage",
        page: () => EditPasswordPage(),
        binding: SettingBinding()),
    GetPage(
        name: "/addpostpage",
        page: () => AddPostPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => AddPostController(),
          ),
        )),
    GetPage(
        name: "/detailpostpage",
        page: () => DetailPostPage(),
        binding: SosialMediaBinding()),
    GetPage(
        name: "/placedetailpage",
        page: () => PlacesDetailPageView(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => PlacesDetailController(),
          ),
        )),
    GetPage(
        name: "/profilepostpage",
        page: () => ProfilePostPage(),
        binding: SosialMediaBinding()),
  ];
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => WorkoutProgramController(), fenix: true);
    Get.lazyPut(() => WorkoutChallangeController(), fenix: true);
    Get.lazyPut(() => PlacesController(), fenix: true);
    Get.lazyPut(() => SocialMediaController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
