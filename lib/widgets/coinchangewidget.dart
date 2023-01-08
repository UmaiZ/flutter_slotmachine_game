import 'package:flutter/material.dart';
import 'package:flutter_slotmachine/helpers/colors.dart';

class CoinChangeWidget extends StatelessWidget {
  final bool isTrue;
  final String coinValue;
  const CoinChangeWidget(
      {super.key, required this.isTrue, required this.coinValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kprimarycolor, ksecondarycolor]),
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(color: kprimarycolor)),
      child: Center(
        child: Text(
          coinValue,
          style: TextStyle(
              color: isTrue ? kyellowcolor : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 23),
        ),
      ),
    );
  }
}
