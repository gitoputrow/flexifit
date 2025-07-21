import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pain/feature/MainController.dart';
import 'package:pain/feature/authentification/controller/ForgotPasswordController.dart';
import 'package:pain/feature/authentification/controller/RegisterController.dart';
import 'package:pain/feature/authentification/view/ForgotPasswordPage.dart';
import 'package:pain/feature/places/controllers/AddReportController.dart';
import 'package:pain/feature/places/controllers/WorkoutPlacesController.dart';
import 'package:pain/feature/places/controllers/PlacesDetailController.dart';
import 'package:pain/feature/places/controllers/ReportsPlaceController.dart';
import 'package:pain/feature/places/views/AddReportView.dart';
import 'package:pain/feature/places/views/PlaceReportView.dart';
import 'package:pain/feature/places/views/PlacesDetailPageView.dart';
import 'package:pain/feature/profile/controller/ProfileController.dart';
import 'package:pain/feature/settings/controller/EditPasswordController.dart';
import 'package:pain/feature/settings/controller/EditProfileController.dart';
import 'package:pain/feature/settings/controller/SettingController.dart';
import 'package:pain/feature/social_media/controller/AddPostController.dart';
import 'package:pain/feature/social_media/controller/DetailSocialMediaController.dart';
import 'package:pain/feature/social_media/controller/SocialMediaController.dart';
import 'package:pain/feature/social_media/controller/SocialMediaProfileController.dart';
import 'package:pain/feature/social_media/view/SearchUsernamePage.dart';
import 'package:pain/feature/social_media/view/SocialMediaProfilePage.dart';
import 'package:pain/feature/workout/controller/WorkoutFinishController.dart';
import 'package:pain/feature/workout/controller/WorkoutListController.dart';
import 'package:pain/feature/workout/controller/WorkoutProgressController.dart';
import 'package:pain/feature/workout/view/WorkoutFinishPage.dart';
import 'package:pain/feature/workout/view/WorkoutRestPage.dart';
import 'package:pain/feature/workout/view/WorkoutStartPage.dart';
import 'package:pain/feature/challenge/controller/WorkoutChallengeController.dart';
import 'package:pain/feature/challenge/controller/WorkoutChallengeDetailController.dart';
import 'package:pain/feature/workout_program/controller/WorkoutProgramController.dart';
import 'package:pain/feature/authentification/view/splashscreen.dart';
import 'package:pain/feature/MainPage.dart';
import 'package:pain/feature/social_media/view/SosmedPage.dart';
import 'package:pain/feature/settings/view/EditPasswordPage.dart';
import 'package:pain/feature/settings/view/EditProfilePage.dart';
import 'package:pain/feature/settings/view/SettingPageView.dart';
import 'package:pain/feature/social_media/view/AddPostPage.dart';
import 'package:pain/feature/challenge/view/ChallangeLevelPage.dart';
import 'package:pain/feature/workout/view/WorkoutPreparePage.dart';
import 'package:pain/feature/authentification/view/RegisterPage.dart';

import 'feature/authentification/controller/LoginController.dart';
import 'feature/authentification/view/LoginPage.dart';
import 'feature/social_media/controller/SearchUsernameController.dart';
import 'feature/workout/view/WorkoutListPage.dart';
import 'feature/social_media/view/DetailPostPage.dart';

class appRoutes {
  static final pages = <GetPage>[
    GetPage(
      name: "/splashscreen",
      page: () => SplashScreen(),
    ),
    GetPage(
      name: "/login",
      page: () => const LoginPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => LoginController(),
        ),
      ),
    ),
    GetPage(
      name: "/regist",
      page: () => const RegisterPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => RegisterController(),
        ),
      ),
    ),
    GetPage(
        name: "/dashboard",
        page: () => const MainView(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => MainController(),
          ),
        )),
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
        page: () => const WorkoutListPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => WorkoutListController(),
          ),
        )),
    GetPage(
        name: "/workoutstart",
        page: () => const WorkoutStartPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => WorkoutProgressController(),
          ),
        )),
    GetPage(
        name: "/workoutrest",
        page: () => const WorkoutRestPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => WorkoutProgressController(),
          ),
        )),
    GetPage(
        name: "/workoutfinish",
        page: () => const WorkoutFinishPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => WorkoutFinishController(),
          ),
        )),
    GetPage(
      name: "/workoutprepare",
      page: () => const WorkoutPreparePage(),
    ),
    GetPage(
        name: "/settingpage",
        page: () => SettingPageView(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => SettingController(),
          ),
        )),
    GetPage(
        name: "/editprofilepage",
        page: () => const EditProfilePage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => EditProfileController(),
          ),
        )),
    GetPage(
        name: "/editpasswordpage",
        page: () => EditPasswordPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => EditPasswordController(),
          ),
        )),
    GetPage(
        name: "/addpostpage",
        page: () => const AddPostPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => AddPostController(),
          ),
        )),
    GetPage(
        name: "/detailpostpage",
        page: () => DetailPostPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => Detailsocialmediacontroller(),
          ),
        )),
    GetPage(
        name: "/userprofilepage",
        page: () => const SocialMediaProfilePage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => SocialMediaProfileController(),
          ),
        )),
    GetPage(
        name: "/placedetailpage",
        page: () => const PlacesDetailPageView(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => PlacesDetailController(),
          ),
        )),
    GetPage(
        name: "/addreportpage",
        page: () => const AddReportsView(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => AddReportController(),
          ),
        )),
    GetPage(
        name: "/placereportpage",
        page: () => const PlaceReportView(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => ReportsPlaceController(),
          ),
        )),
    GetPage(
        name: "/searchuserpage",
        page: () => const SearchUsernamePage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => SearchUsernameController(),
          ),
        )),
    GetPage(
        name: "/forgotpass",
        page: () => const ForgotPasswordPage(),
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => ForgotPasswordController(),
          ),
        )),
  ];
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => WorkoutProgramController(), fenix: true);
    Get.lazyPut(() => WorkoutChallengeController(), fenix: true);
    Get.lazyPut(() => WorkoutPlacesController(), fenix: true);
    Get.lazyPut(() => SocialMediaController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
