import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/services/post_change_nickname.dart';
import 'package:just/views/widgets/user_info_page/username_chage_popup.dart';
import 'package:get/get.dart';
import 'package:just/views/widgets/utils/show_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileCard extends StatefulWidget {
  const UserProfileCard({super.key});

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  final LoginController lc = Get.put(LoginController());

  void changeUsernameState(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (lc.nickname == value) return;
    if (value.isEmpty) {
      showToast('닉네임을 입력하세요.');
    } else if (value.length < 3 || value.length > 10) {
      showToast('닉네임은 3글자 이상 10글자 이하로 입력해주세요.');
    } else if (!RegExp(r'^[a-zA-Z가-힣_]*[a-zA-Z가-힣][a-zA-Z가-힣_]*$')
        .hasMatch(value)) {
      showToast('닉네임은 한글, 영어, 숫자만 입력 가능합니다.');
    } else {
      EasyLoading.show(status: '닉네임 변경 중...');
      final response = await postChangeNickname(value);
      if (response?.statusCode != 200) {
        EasyLoading.showError('닉네임 변경 실패!');
        return;
      }
      setState(() {
        lc.nickname = value;
      });
      prefs.setString('nick-name', value);
      EasyLoading.showSuccess('닉네임 변경 완료!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 28, 27, 31),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
        ),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40.0,
                  backgroundImage:
                      AssetImage('assets/background/background1.jpg'),
                ),
                const SizedBox(width: 16.0),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lc.nickname,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
                Expanded(child: Container()),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => UsernameChangePopup(
                            currentNickname: lc.nickname,
                            changeUsernameState: changeUsernameState));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
