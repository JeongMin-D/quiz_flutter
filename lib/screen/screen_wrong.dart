import 'package:flutter/material.dart';
import 'package:quiz_app_test/model/model_quiz.dart';
import 'package:quiz_app_test/screen/screen_home.dart';
import 'package:quiz_app_test/model/model_quiz.dart';

class WrongScreen extends StatelessWidget {
  List<int> answers;
  List<Quiz> quizs;
  WrongScreen({this.answers, this.quizs});
  final List<String> quiz_title = List();
  final List<String> quiz_answer = List();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    var wrongMap = Map<String, String>();
    for (int i = 0; i < quizs.length; i++) {
      if (quizs[i].answer != answers[i]) {
        wrongMap[quizs[i].title] = quizs[i].candidates[quizs[i].answer];
        quiz_title.add(quizs[i].title);
        quiz_answer.add(quizs[i].candidates[quizs[i].answer]);
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('오답노트'),
          backgroundColor: Color(0xff3338ca),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.home),
              tooltip: 'Home!',
              // ignore: sdk_version_set_literal
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()))
              },
            )
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: wrongMap.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Center(
                        child: Text(
                      '문제: ${quiz_title[index]}\n정답: ${quiz_answer[index]}',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
