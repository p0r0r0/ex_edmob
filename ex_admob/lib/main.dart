import 'package:admob_flutter/admob_flutter.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:exadmob/services/admob_service.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Zzz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// 서비스 폴더안에 서비스 클래스를 복사해와야 사용할수 있음!!!!
  final ams = AdMobService();
// initState로 초기화를 시켜야되서 밑에처럼 아이디를 불러와서 써야함!!
  @override
  void initState() {
    super.initState();
    Admob.initialize(ams.getAdMobAppId());
    initPlayer();
  }

  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  bool isPlaying = false;

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  @override
  Widget build(BuildContext context) {
    var querydata = MediaQuery.of(context);
    var screen_height = querydata.size.height;
    var screen_width = querydata.size.width;

    String songTitle = '제목';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/b_image1.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: screen_height * 0.05,
            ),
//            Container(
//              height: screen_height * 0.1,
//              child: AdmobBanner(
//                adUnitId: ams.getBannerAdId(),
//                adSize: AdmobBannerSize.FULL_BANNER,
//              ),
//            ),
            Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: screen_width * 0.05,
                          top: screen_width * 0.02,
                          bottom: screen_width * 0.02),
                      alignment: Alignment.centerLeft,
                      height: screen_height * 0.1,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Container(
                      padding: EdgeInsets.all(7.0),
                      height: screen_height * 0.4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          "assets/images/image2.gif",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: screen_height * 0.05),
                    Text(
                      songTitle,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: screen_height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              advancedPlayer.pause();
                              print('back');
                            });
                          },
                          child: Container(
                            height: screen_height * 0.08,
                            width: screen_width * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.skip_previous,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (isPlaying) {
                                audioCache.play('music1.mp3');
                                isPlaying = true;
                                print(isPlaying);
                              }
                            });

                            print('play');
                          },
                          child: Container(
                            height: screen_height * 0.08,
                            width: screen_width * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              isPlaying == true
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            setState(() {
                              advancedPlayer.stop();
                              print('forword!!');
                            });
                          },
                          child: Container(
                            height: screen_height * 0.08,
                            width: screen_width * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.skip_next,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            setState(() {
                              print('Timer!!!');
                            });
                          },
                          child: Container(
                            height: screen_height * 0.06,
                            width: screen_width * 0.17,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                'TIMER',
                                style: TextStyle(
                                    color: Colors.red.shade900, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
//                    Container(
//                      height: screen_height * 0.1,
//                      width: screen_width * 1,
//                      child: Slider(
//                        activeColor: Colors.black,
//                        inactiveColor: Colors.pink,
//                        value: _position.inSeconds.toDouble(),
//                        min: 0.0,
//                        max: _duration.inSeconds.toDouble(),
//                        onChanged: (double value) {
//                          setState(() {
//                            seekToSecond(value.toInt());
//                            value = value;
//                          });
//                        },
//                      ),
//                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
