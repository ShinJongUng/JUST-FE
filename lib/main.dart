import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/home_page.dart';
import 'package:just/views/pages/login_page.dart';
import 'package:just/views/pages/post_page.dart';
import 'package:just/views/pages/search_page.dart';
import 'package:just/views/pages/setting_page.dart';
import 'package:just/views/pages/signup_page.dart';
import 'package:just/views/pages/story_page.dart';
import 'package:just/views/pages/user_info_page.dart';
import 'package:just/views/pages/user_post_page.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_KEY']);
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    final LoginController lc = Get.put(LoginController());
    isDeviceLogin();
    super.initState();
  }

  void isDeviceLogin() async {
    final storage = FlutterSecureStorage();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? platform = prefs.getString('platform');
    final String? accessToken = await storage.read(key: 'access-token');
    final LoginController lc = Get.put(LoginController());
    if ((platform == 'kakao' || platform == 'apple') && accessToken != null) {
      lc.registerAccessToken(accessToken);
      lc.login();
    } else {
      lc.logout();
      prefs.setString('platform', 'none');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const HomePage()),
        GetPage(name: "/post", page: () => const PostPage()),
        GetPage(name: "/story", page: () => const StoryPage()),
        GetPage(name: "/user-info", page: () => const UserInfoPage()),
        GetPage(name: "/login", page: () => const LoginPage()),
        GetPage(name: "/signup", page: () => SignUpPage()),
        GetPage(name: "/search", page: () => const SearchPage()),
        GetPage(name: "/user-post", page: () => const UserPostPage()),
        GetPage(name: "/setting", page: () => const SettingPage()),
      ],
      builder: EasyLoading.init(),
    );
  }
}
