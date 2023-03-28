import 'package:flutter/material.dart';
import 'package:just/views/widgets/utils/platform_ok_cancel_dialog.dart';

class StoryPostWidget extends StatefulWidget {
  @override
  _StoryPostWidgetState createState() => _StoryPostWidgetState();
}

class _StoryPostWidgetState extends State<StoryPostWidget> {
  bool _isAnonymous = false;
  double keyboardHeight = 0.0;

  @override
  void initState() {
    super.initState();
    // 키보드 높이 구하기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      setState(() {
        this.keyboardHeight = keyboardHeight;
      });
    });
  }

  void _toggleAnonymous() {
    setState(() {
      _isAnonymous = !_isAnonymous;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('글 작성 페이지'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PlatformOkCancelDialog(
                    title: '글 작성 취소',
                    content: '글 작성을 취소하시겠습니까?',
                    okText: '예',
                    cancelText: '아니요');
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/test1.jpg'),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '아무 고민이나 괜찮아요.',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: keyboardHeight,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Checkbox(
                          value: _isAnonymous,
                          onChanged: (value) {
                            _toggleAnonymous();
                          },
                        ),
                        Text(
                          '익명으로 글 작성하기',
                          style: TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                          child: Text('페이지 추가 하기'),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
