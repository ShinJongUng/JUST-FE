import 'dart:convert';

import 'package:just/models/post_arguments.dart';

class TestData {
  late final String jsonString;
  late final List<PostArguments> data;

  TestData() {
    jsonString = '''[
{
    "numbersOfComments": 10,
    "numbersOfLikes": 10,
    "bgImageId": 1,
    "pagesText": ["여행이란,\\n우리가 사는 장소를 바꿔주는 것이 아니라\\n우리의 생각과 편견을 바꿔주는 것이다.", "여행은 정신을\\n다시 젊어지게 하는 샘이다.", "여행은 정신을\\n다시 젊어지게 하는 샘이다.", "여행은 정신을\\n다시 젊어지게 하는 샘이다.", "여행은 정신을\\n다시 젊어지게 하는 샘이다.", "여행은 정신을\\n다시 젊어지게 하는 샘이다.", "여행은 정신을\\n다시 젊어지게 하는 샘이다."]
  },
  {
    "numbersOfComments": 20,
    "numbersOfLikes": 20,
    "bgImageId": 2,
    "pagesText": ["나는 어렸을때 부터 내가 너무너무 \\n좋아하 여자 앞에서는 이상하게 뚝딱거리고\\n말도 괜히 장황하게 길어진다\\n그런 여자애들이랑은 잘 안될 확률이 높더라\\n관심크게 없는 여자에게는 장난도 잘치고 \\n근데 또 매너랍시고 인간적으로 챙겨줄것도 챙겨주면\\n얘가 뜬금없이 나를 좋아하더니", "고백하거나 술먹고 나 찾고 그러더라..\\n근데 나이먹고 연애 도중에도 이게 발동되는게.\\n처음에 이 여자애가 괜찮은데 잘해 볼까~싶어서 딱 그정도 생각으로 연애시작했는데\\n얘가 알면 알수록 너무 더 괜찮고 더 사랑하게되면"]
  },
  {
    "numbersOfComments": 30,
    "numbersOfLikes": 30,
    "bgImageId": 3,
    "pagesText": ["여긴 어디"]
  },
  {
    "numbersOfComments": 40,
    "numbersOfLikes": 40,
    "bgImageId": 4,
    "pagesText": ["hi"]
  }
]''';
    var decodedData = jsonDecode(jsonString) as List;

    data = decodedData
        .map((item) => PostArguments.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
