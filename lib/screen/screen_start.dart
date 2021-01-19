import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quiz_app_test/screen/screen_home.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:quiz_app_test/config/constants.dart';

class StartApp extends StatefulWidget {
  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  SwiperController _controller = SwiperController();
  CountDownController timerController = CountDownController();
  int _timer = timer;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xff3338ca),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '주원통운과 함께',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold),
                ),
                Center(
                  child: Image.asset(
                    'images/quiz.jpeg',
                    width: width * 1.0,
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xff3338ca)),
                    ),
                    width: width * 0.1,
                    height: height * 0.1,
                    child: Swiper(
                        controller: _controller,
                        loop: false,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildQuizCard(context);
                        })),
              ],
            )));
  }

  Widget _buildQuizCard(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xff3338ca)),
            color: Color(0xff3338ca)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: CircularCountDownTimer(
                controller: timerController,
                color: Color(0xff3338ca),
                textStyle: TextStyle(color: Color(0xff3338ca)),
                duration: 3,
                isReverse: true,
                isReverseAnimation: true,
                fillColor: Color(0xff3338ca),
                backgroundColor: Color(0xff3338ca),
                height: 80,
                width: 80,
                isTimerTextShown: false,
                onComplete: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ))
            ]));
  }
}
