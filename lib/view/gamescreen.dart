import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slotmachine/helpers/colors.dart';
import 'package:flutter_slotmachine/services/gameservice.dart';
import 'package:flutter_slotmachine/widgets/coinchangewidget.dart';
import 'package:flutter_slotmachine/widgets/spinnerwidget.dart';
import 'package:just_audio/just_audio.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  );

  late final AnimationController spinnercontroller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  );

  var gameserivce = GameService();

  @override
  void initState() {
    super.initState();
    gameserivce.playSound('riseup');
    controller.forward();
    spinnercontroller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double res_height = MediaQuery.of(context).size.height;
    double res_width = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kprimarycolor, ksecondarycolor])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: EdgeInsets.only(left: 15, right: 15),
          children: [
            SizedBox(
              height: res_height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      gameserivce.reset();
                    });
                  },
                  child: const Icon(
                    Icons.restart_alt_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Image.asset(
                  'assets/Graphics/gfx-slot-machine.png',
                  width: res_width * 0.6,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 40,
                  ),
                )
              ],
            ),
            SizedBox(
              height: res_height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'YOUR\nCOINS',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        '${gameserivce.yourcoins.toString()}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${gameserivce.highscore.toString()}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'HIGH\nSCORE',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: res_height * 0.02,
            ),
            Column(
              children: [
                spinnerwidgetbox(
                  spinnerImage: '${gameserivce.items[gameserivce.reels[0]]}',
                  isSpin: false,
                  controller: spinnercontroller,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    spinnerwidgetbox(
                      spinnerImage:
                          '${gameserivce.items[gameserivce.reels[1]]}',
                      isSpin: false,
                      controller: spinnercontroller,
                    ),
                    spinnerwidgetbox(
                      spinnerImage:
                          '${gameserivce.items[gameserivce.reels[2]]}',
                      isSpin: false,
                      controller: spinnercontroller,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    spinnercontroller.forward(from: 0);
                    var spin = gameserivce.spin();
                    if (spin == "GAME END") {
                      showPopup('GAME END');
                    }
                    if (spin == "WIN") {
                      showPopup('WIN');
                    }
                    setState(() {});
                  },
                  child: spinnerwidgetbox(
                    spinnerImage: 'gfx-spin.png',
                    isSpin: true,
                    controller: spinnercontroller,
                  ),
                )
              ],
            ),
            SizedBox(
              height: res_height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    gameserivce.playSound('casino-chips');

                    setState(() {
                      gameserivce.coin10 = true;
                      controller.forward(from: 0);
                    });
                  },
                  child: CoinChangeWidget(
                    isTrue: gameserivce.coin10,
                    coinValue: '10',
                  ),
                ),
                Container(
                  child: SlideTransition(
                    position: Tween<Offset>(
                            begin: Offset(0, 0),
                            end: Offset(gameserivce.coin10 ? -2 : 2, 0))
                        .animate(controller),
                    child: Image.asset(
                      'assets/Graphics/gfx-casino-chips.png',
                      height: 40,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    gameserivce.playSound('casino-chips');
                    setState(() {
                      gameserivce.coin10 = false;
                      controller.forward(from: 0);
                    });
                  },
                  child: CoinChangeWidget(
                    isTrue: !gameserivce.coin10,
                    coinValue: '20',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  showPopup(type) {
    double res_height = MediaQuery.of(context).size.height;
    double res_width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            height: res_height * 0.35,
            width: res_width * 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Material(
                child: Column(
                  children: [
                    Container(
                      width: res_width * 0.9,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.centerRight,
                              colors: [kprimarycolor, ksecondarycolor])),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            type == "GAME END" ? "GAME OVER" : "YOU WIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/Graphics/gfx-seven-reel.png',
                      width: 100,
                    ),
                    Spacer(),
                    Text(
                      type == "GAME END"
                          ? "Bad Luck! You lost all of the coins.\nLet's play again"
                          : "Hurray! You win the spin.\nLet's play again",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 17),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          if (type == "GAME END") {
                            Navigator.pop(context);
                            setState(() {
                              gameserivce.reset();
                            });
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          type == "GAME END" ? "NEW GAME" : "CONTINUE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5)),
                            foregroundColor:
                                MaterialStateProperty.all(kprimarycolor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: kprimarycolor, width: 3))))),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
