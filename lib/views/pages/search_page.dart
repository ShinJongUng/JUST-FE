import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textInputController = TextEditingController();
  final List<bool> _isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  Expanded(
                    child: TextField(
                      controller: _textInputController,
                      decoration: InputDecoration(
                        hintText: '검색어를 입력하세요',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: _textInputController.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('검색'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                  height: 40,
                  child: ToggleButtons(
                    isSelected: _isSelected,
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < _isSelected.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            _isSelected[buttonIndex] = true;
                          } else {
                            _isSelected[buttonIndex] = false;
                          }
                        }
                      });
                    },
                    children: const [
                      Text('무작위'),
                      Text('최신순'),
                      Text('인기순'),
                    ],
                  )),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return const ListTile(
                      title: Text('111'),
                      subtitle: Text('222'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
