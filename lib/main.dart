import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/base_layout.dart';
import 'package:just/getX/post_controller.dart';
import 'package:just/views/pages/login_page.dart';
import 'package:just/views/pages/post_page.dart';
import 'package:just/views/pages/search_page.dart';
import 'package:just/views/pages/setting_page.dart';
import 'package:just/views/pages/signup_page.dart';
import 'package:just/views/pages/single_story_page.dart';
import 'package:just/views/pages/story_page.dart';
import 'package:just/views/pages/user_info_page.dart';
import 'package:just/views/pages/user_post_page.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<GetPage> appRoutes = [
  GetPage(name: "/", page: () => const BaseLayout()),
  GetPage(name: "/post", page: () => const PostPage()),
  GetPage(name: "/story", page: () => const StoryPage()),
  GetPage(name: "/user-info", page: () => const UserInfoPage()),
  GetPage(name: "/login", page: () => const LoginPage()),
  GetPage(name: "/signup", page: () => SignUpPage()),
  GetPage(name: "/search", page: () => const SearchPage()),
  GetPage(name: "/user-post", page: () => const UserPostPage()),
  GetPage(name: "/setting", page: () => const SettingPage()),
  GetPage(name: "/single-post", page: () => const SinglePostPage())
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/config/.env');
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_KEY']);
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => PostController());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<void> _isDeviceLoggedInFuture;

  @override
  void initState() {
    _isDeviceLoggedInFuture = isDeviceLogin();
    super.initState();
  }

  static Future<void> isDeviceLogin() async {
    const storage = FlutterSecureStorage();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? platform = prefs.getString('platform');
    final String? accessToken = await storage.read(key: 'access-token');
    final String? nickName = prefs.getString('nick-name');
    final LoginController lc = Get.find();
    if ((platform == 'kakao' || platform == 'apple') &&
        (accessToken != null || accessToken!.isNotEmpty)) {
      lc.registerNickname(nickName);
      lc.registerAccessToken(accessToken);
      lc.login();
      print(lc.accessToken);
    } else {
      lc.logout();
      prefs.setString('platform', 'none');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.greenAccent,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.amber,
          secondary: Colors.greenAccent,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.greenAccent,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.amber,
          secondary: Colors.greenAccent,
        ),
      ),
      color: Colors.greenAccent,
      home: FutureBuilder<void>(
        future: _isDeviceLoggedInFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                ),
              ),
            );
          }
          return const BaseLayout();
        },
      ),
      getPages: appRoutes,
      builder: EasyLoading.init(),
    );
  }
}
