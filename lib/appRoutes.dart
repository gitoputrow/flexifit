import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pain/Page/IntroPage/splashscreen.dart';
import 'package:pain/Page/MainPage/DashboardPage.dart';
import 'package:pain/Page/MainPage/SettingPage/EditPasswordPage.dart';
import 'package:pain/Page/MainPage/SettingPage/EditProfilePage.dart';
import 'package:pain/Page/MainPage/SettingPage/SettingPage.dart';
import 'package:pain/Page/MainPage/WorkoutPage/ChallangeLevelPage.dart';
import 'package:pain/Page/MainPage/WorkoutPage/WorkoutFinishPage.dart';
import 'package:pain/Page/MainPage/WorkoutPage/WorkoutListPage.dart';
import 'package:pain/Page/MainPage/WorkoutPage/WorkoutPreparePage.dart';
import 'package:pain/Page/MainPage/WorkoutPage/WorkoutRestPage.dart';
import 'package:pain/Page/MainPage/WorkoutPage/WorkoutStartPage.dart';
import 'package:pain/Page/registerpage/RegisterPage.dart';
import 'package:pain/binding/AuthentificationBinding.dart';
import 'package:pain/binding/DashboardBinding.dart';
import 'package:pain/binding/WorkoutBinding.dart';

import 'Page/IntroPage/LoginPage.dart';
import 'binding/SettingBinding.dart';

class appRoutes {
  static final pages = <GetPage>[
    GetPage(name: "/splashscreen", 
    page: () => SplashScreen(),
    ),
    GetPage(name: "/login", 
    page: () => LoginPage(),
    binding: AuthentificationBinding()
    ),
    GetPage(name: "/regist", 
    page: () => RegisterPage(),
    binding: AuthentificationBinding()
    ),
    GetPage(name: "/dashboard", 
    page: () => DashboardPage(),
    binding: DashboardBinding()
    ),
    GetPage(name: "/challangelevel", 
    page: () => ChallangeLevelPage(),
    binding: WorkoutBinding()
    ),
    GetPage(name: "/workoutlist", 
    page: () => WorkoutListPage(),
    binding: WorkoutBinding()
    ),
    GetPage(name: "/workoutstart", 
    page: () => WorkoutStartPage(),
    binding: WorkoutBinding()
    ),
    GetPage(name: "/workoutrest", 
    page: () => WorkoutRestPage(),
    binding: WorkoutBinding()
    ),
    GetPage(name: "/workoutfinish", 
    page: () => WorkoutFinishPage(),
    binding: WorkoutBinding()
    ),
    GetPage(name: "/workoutprepare", 
    page: () => WorkoutPreparePage(),
    binding: WorkoutBinding()
    ),
    GetPage(name: "/settingpage", 
    page: () => SettingPage(),
    binding: SettingBinding()
    ),
    GetPage(name: "/editprofilepage", 
    page: () => EditProfilePage(),
    binding: SettingBinding()
    ),
    GetPage(name: "/editpasswordpage", 
    page: () => EditPasswordPage(),
    binding: SettingBinding()
    ),
  ];
}