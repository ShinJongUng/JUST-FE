import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/views/pages/webview_page.dart';
import 'package:just/views/widgets/setting_page/drop_user_dialog.dart';
import 'package:just/views/widgets/setting_page/logout_dialog.dart';
import 'package:just/views/widgets/utils/platform_ok_cancel_dialog.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('로그아웃'),
            onTap: () {
              showDialog(
                  context: context, builder: (context) => const LogoutDialog());
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('개인정보 처리방침'),
            onTap: () {
              Get.to(() => const WebViewScreen(
                  url:
                      'https://devung.notion.site/c73311d98d4b4294b09a0e2b22890393?pvs=4',
                  title: 'Just 개인정보처리방침'));
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever_rounded),
            title: const Text('회원 탈퇴'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => const DropUserDialog());
            },
          ),
        ],
      ),
    );
  }
}
