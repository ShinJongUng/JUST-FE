import 'package:flutter/material.dart';
import 'package:just/views/widgets/setting_page/logout_dialog.dart';
import 'package:just/views/widgets/utils/platform_ok_cancel_dialog.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('로그아웃'),
            onTap: () {
              showDialog(
                  context: context, builder: (context) => const LogoutDialog());
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('개인정보처리방침'),
            onTap: () {
              // 개인정보 처리 방침 보기 기능 구현
            },
          ),
        ],
      ),
    );
  }
}
