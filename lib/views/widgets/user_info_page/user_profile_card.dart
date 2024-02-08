import 'package:flutter/material.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/views/widgets/user_info_page/username_chage_popup.dart';
import 'package:get/get.dart';

class UserProfileCard extends StatefulWidget {
  const UserProfileCard({super.key});

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  final LoginController lc = Get.find();

  @override
  Widget build(BuildContext context) {
    pressedChangeNicknameButton() {
      showDialog(
          context: context, builder: (context) => const UsernameChangePopup());
    }

    return Obx(
      () => Container(
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
                          lc.nickname.value,
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
                    onPressed: pressedChangeNicknameButton,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
