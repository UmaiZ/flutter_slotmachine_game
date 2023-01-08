import 'package:flutter/material.dart';

class spinnerwidgetbox extends StatefulWidget {
  final spinnerImage;
  final isSpin;
  final controller;
  spinnerwidgetbox(
      {super.key,
      required this.spinnerImage,
      required this.isSpin,
      required this.controller});

  @override
  State<spinnerwidgetbox> createState() => spinnerwidgetboxState();
}

class spinnerwidgetboxState extends State<spinnerwidgetbox>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double res_height = MediaQuery.of(context).size.height;
    double res_width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: res_width * 0.435,
      child: Stack(
        children: [
          Image.asset(
            'assets/Graphics/gfx-reel.png',
          ),
          SlideTransition(
            position: Tween<Offset>(
                    begin: Offset(0, !widget.isSpin ? -0.15 : 0),
                    end: Offset(0, 0))
                .animate(widget.controller),
            child: Image.asset('assets/Graphics/${widget.spinnerImage}'),
          )
        ],
      ),
    );
  }
}
