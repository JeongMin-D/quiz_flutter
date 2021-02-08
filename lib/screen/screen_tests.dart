import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quiz_app_test/model/model_quiz.dart';
import 'package:quiz_app_test/screen/screen_result.dart';
import 'package:quiz_app_test/widget/widget_candidate.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:quiz_app_test/config/constants.dart';

class Quiztest extends StatefulWidget {
  List<Quiz> quizs;
  Quiztest({this.quizs});
  @override
  _QuiztestState createState() => _QuiztestState();
}

class _QuiztestState extends State<Quiztest> {
  var _answers = List.filled(10, -1); //문제 수를 정하기 위해 첫번째 숫자를 바꿔주세요.
  //List<int> _answers = [-1, -1, -1];
  List<bool> _answerState = [false, false, false, false];
  int _currentIndex = 0;
  SwiperController _controller = SwiperController();
  CountDownController timerController = CountDownController();
  int _timer = timer;
  int life = 3;

  void _showDialog_cor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pop(context);
        });

        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          content: SizedBox(
            height: 200,
            child: Center(
                child: SizedBox(
              child: Text("정답입니다."),
              height: 50.0,
              width: 50.0,
            )),
          ),
        );
      },
    );
  }

  void _showDialog_wro() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pop(context);
        });

        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          content: SizedBox(
            height: 200,
            child: Center(
                child: SizedBox(
              child: Text("오답입니다."),
              height: 50.0,
              width: 50.0,
            )),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
            ),
            width: width * 1,
            height: height * 1,
            child: Swiper(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              loop: false,
              itemCount: widget.quizs.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildQuizCard(widget.quizs[index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              child: CircularCountDownTimer(
            controller: timerController,
            color: Colors.white,
            duration: _timer,
            isReverse: true,
            isReverseAnimation: true,
            fillColor: Color(0xff3338ca),
            backgroundColor: Colors.white,
            height: 80,
            width: 80,
            onComplete: () {
              print("passed");

              if (_currentIndex == widget.quizs.length - 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      answers: _answers,
                      quizs: widget.quizs,
                    ),
                  ),
                );
              } else {
                if (widget.quizs[_currentIndex].answer !=
                    _answers[_currentIndex]) {
                  life -= 1;
                  if (life <= 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          answers: _answers,
                          quizs: widget.quizs,
                        ),
                      ),
                    );
                  }
                }

                _answerState = [false, false, false, false];
                _currentIndex += 1;
                // _controller.next();
              }
            },
          )),
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Q' + (_currentIndex + 1).toString() + '.',
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Life: ' + (life).toString(),
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.012),
            child: AutoSizeText(
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            children: _buildCandidates(width, quiz),
          ),
          Container(
            padding: EdgeInsets.all(width * 0.024),
            child: Center(
              child: ButtonTheme(
                minWidth: width * 0.5,
                height: height * 0.05,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RaisedButton(
                  child: _currentIndex == widget.quizs.length - 1
                      ? Text('결과보기')
                      : Text('다음문제'),
                  textColor: Colors.white,
                  color: Color(0xff3338ca),
                  onPressed: _answers[_currentIndex] == -1
                      ? null
                      : () {
                          if (_currentIndex == widget.quizs.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                  answers: _answers,
                                  quizs: widget.quizs,
                                ),
                              ),
                            );
                          } else if (life <= 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                  answers: _answers,
                                  quizs: widget.quizs,
                                ),
                              ),
                            );
                          } else {
                            if (widget.quizs[_currentIndex].answer !=
                                _answers[_currentIndex]) {
                              life -= 1;
                              if (life <= 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultScreen(
                                      answers: _answers,
                                      quizs: widget.quizs,
                                    ),
                                  ),
                                );
                              }
                            }

                            _answerState = [false, false, false, false];
                            _currentIndex += 1;
                            _controller.next();
                          }
                        },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];
    for (int i = 0; i < 4; i++) {
      _children.add(
        CandWidget(
          index: i,
          text: quiz.candidates[i],
          width: width,
          answerState: _answerState[i],
          tap: () {
            setState(() {
              for (int j = 0; j < 4; j++) {
                if (j == i) {
                  _answerState[j] = true;
                  _answers[_currentIndex] = j;
                } else {
                  _answerState[j] = false;
                }
              }
            });
            if (widget.quizs[_currentIndex].answer == _answers[_currentIndex]) {
              _showDialog_cor();
            } else if (widget.quizs[_currentIndex].answer !=
                _answers[_currentIndex]) {
              _showDialog_wro();
            }
          },
        ),
      );
      _children.add(
        Padding(
          padding: EdgeInsets.all(width * 0.024),
        ),
      );
    }
    return _children;
  }
}
