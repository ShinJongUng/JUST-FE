import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just/getX/post_write_controller.dart';
import 'package:just/services/post_story_post.dart';
import 'package:textfield_tags/textfield_tags.dart';

class PostTagPage extends StatefulWidget {
  const PostTagPage({super.key});

  @override
  State<PostTagPage> createState() => _PostTagPageState();
}

class _PostTagPageState extends State<PostTagPage> {
  final PostWriteController pwc = Get.find();
  late double _distanceToField;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  void onPressedPostButton() async {
    try {
      EasyLoading.show(status: '로딩중...');
      pwc.isPosting.value = true;
      final response = await postStoryPost(
          pwc.textControllers.map((e) => e.text.trim()).toList(),
          pwc.imageId.value,
          pwc.tagController.getTags!);

      if (response != null) {
        EasyLoading.showSuccess('글 작성 성공!');
      } else {
        EasyLoading.showError('글 작성 실패\n잠시 후 다시 시도해주세요.');
      }
    } catch (e) {
      EasyLoading.showError('글 작성 실패\n잠시 후 다시 시도해주세요.');
    } finally {
      pwc.isPosting.value = false;
    }

    if (!pwc.isPosting.value) {
      Get.offAllNamed('/');
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.delete<PostWriteController>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('태그 등록'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
              pwc.syncTag();
            },
          ),
        ),
        body: Column(children: [
          TextFieldTags(
            textfieldTagsController: pwc.tagController,
            initialTags: pwc.tags,
            textSeparators: const [' ', ','],
            letterCase: LetterCase.normal,
            validator: (String tag) {
              if (tag.length < 2) {
                return '태그는 2글자 이상이어야 합니다.';
              }
              if (pwc.tagController.getTags!.length > 4) {
                return '태그는 5개까지만 등록 가능합니다.';
              }
              if (pwc.tagController.getTags!.contains(tag)) {
                return '이미 등록된 태그입니다.';
              }
              return null;
            },
            inputfieldBuilder:
                (context, tec, fn, error, onChanged, onSubmitted) {
              return ((context, sc, tags, onTagDelete) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: tec,
                        focusNode: fn,
                        decoration: InputDecoration(
                          isDense: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 74, 137, 92),
                              width: 3.0,
                            ),
                          ),
                          hintText:
                              pwc.tagController.hasTags ? '' : "태그를 입력하세요...",
                          errorText: error,
                          prefixIconConstraints:
                              BoxConstraints(maxWidth: _distanceToField * 0.74),
                          prefixIcon: tags.isNotEmpty
                              ? SingleChildScrollView(
                                  controller: sc,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: tags.map((String tag) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        color: Colors.amber,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              '#$tag',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(width: 4.0),
                                          InkWell(
                                            child: const Icon(
                                              Icons.cancel,
                                              size: 14.0,
                                              color: Color.fromARGB(
                                                  255, 233, 233, 233),
                                            ),
                                            onTap: () {
                                              onTagDelete(tag);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                                )
                              : null,
                        ),
                        onChanged: onChanged,
                        onSubmitted: onSubmitted,
                      ),
                    ],
                  ),
                );
              });
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('* 태그 없이 작성하면 AI를 통해 자동으로 태그가 등록됩니다',
                    style: TextStyle(
                      fontSize: 12,
                    ))
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              ListTile(
                title: const Text('#연애'),
                subtitle: const Text('게시물 102개'),
                onTap: () {
                  pwc.tagController.onSubmitted('연애');
                },
              ),
              const ListTile(
                title: Text('#고민'),
                subtitle: Text('게시물 21개'),
              ),
              const ListTile(
                title: Text('#걱정'),
                subtitle: Text('게시물 18개'),
              ),
              const ListTile(
                title: Text('#고민'),
                subtitle: Text('게시물 10개'),
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                onPressedPostButton();
              },
              child: const Text('완료'),
            ),
          ),
        ]));
  }
}
