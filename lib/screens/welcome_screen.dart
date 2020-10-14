import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart' as fl_neu;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neumorphic/neumorphic.dart' as neu;
import 'dart:math' as math;
import 'package:sakura/widgets/TestClipper.dart';
import 'package:sakura/assets/images/cherry/cherry-blossom-clippath.dart'
    as cherryClipPath;
import 'package:sakura/widgets/ClipPathShadow.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:tinycolor/tinycolor.dart';

const Color kBaseColor = Color(0xFFFFE7E7);

class WelcomeScreen extends StatefulWidget {
  static final String path = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBaseColor,
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 170,
              right: -20,
              child: Transform.rotate(
                angle: math.pi / 6.0,
                child: Cherry(
                  width: screenWidth * 0.2 < 400 ? screenWidth * 0.2 : 400,
                ),
                // width: screenWidth * 0.5 < 1000 ? screenWidth * 0.5 : 1000,
              ),
            ),
            Positioned(
              top: 0,
              right: -20,
              child: Transform.rotate(
                angle: math.pi / 12.0,
                child: Cherry(
                  width: screenWidth * 0.5 < 1000 ? screenWidth * 0.5 : 1000,
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 300,
              child: TypewriterAnimatedTextKit(
                pause: Duration(milliseconds: 500),
                repeatForever: true,
                speed: Duration(seconds: 1),
                text: ['Sakura\nTecho'],
                textStyle: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            blurRadius: 5,
                            offset: Offset(4, 4),
                            color: Color(0xFFF5D2D2)),
                        Shadow(
                            blurRadius: 2,
                            offset: Offset(-2, -2),
                            color: Color(0xFFFFFFFF))
                      ]),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.3),
                Button(
                  onPressed: (() {}),
                  depth: 8,
                  minDistance: 2,
                  text: 'Login',
                  width: 200,
                  height: 40,
                  color: kBaseColor,
                ),
                SizedBox(
                    height:
                        screenHeight * 0.03 < 100 ? screenHeight * 0.03 : 100),
                Button(
                  color: kBaseColor,
                  text: 'Register',
                  width: 200,
                  height: 40,
                  onPressed: (() {}),
                ),
              ],
            ),
            Positioned(
              top: screenHeight * 0.8,
              left: 33,
              child: Transform.rotate(
                angle: math.pi / 7.5,
                child: Cherry(
                  width: screenWidth * 0.2 < 400 ? screenWidth * 0.2 : 400,
                ),
                // width: screenWidth * 0.5 < 1000 ? screenWidth * 0.5 : 1000,
              ),
            ),
            Positioned(
              top: screenHeight * 0.8,
              right: 15,
              child: Transform.rotate(
                angle: math.pi / 12.0,
                child: Cherry(
                  width: screenWidth * 0.5 < 1000 ? screenWidth * 0.5 : 1000,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Function onPressed;
  final double depth;
  final double minDistance;
  final Color color;
  final String text;
  final double width;
  final double height;
  final fl_neu.NeumorphicShape shape;

  const Button(
      {Key key,
      this.depth = 8,
      @required this.onPressed,
      this.minDistance = 2,
      @required this.color,
      @required this.text,
      @required this.width,
      @required this.height,
      this.shape = fl_neu.NeumorphicShape.concave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fl_neu.NeumorphicButton(
      onPressed: this.onPressed,
      minDistance: this.minDistance,
      style: fl_neu.NeumorphicStyle(
        // lightSource : fl_neu.LightSource.topLeft,
        depth: this.depth,
        color: this.color,
        intensity: 0.8,
        boxShape:
            fl_neu.NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
        shape: this.shape,
      ),
      child: Container(
        width: this.width,
        height: this.height,
        child: Center(
          child: neu.NeuText(this.text,
              emboss: true,
              parentColor: kBaseColor,
              depth: 8,
              style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                color: TinyColor(this.color).darken(5).color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ))),
        ),
      ),
    );
  }
}

class Cherry extends StatelessWidget {
  final String cherrySvgPath = "lib/assets/images/cherry/cherry-blossom.svg";
  final double blurRadius;
  final double spreadRadius;
  final double width;
  final Offset offset;

  Cherry(
      {this.blurRadius = 5,
      this.spreadRadius = 5,
      this.width,
      this.offset = const Offset(6, 4)});

  @override
  Widget build(BuildContext context) {
    return Stack(overflow: Overflow.visible, children: [
      ClipShadowPath(
          clipper: TestClipper(path: parseSvgPath(cherryClipPath.path)),
          shadow: BoxShadow(
            color: Colors.pink[100].withOpacity(0.5),
            offset: this.offset,
            blurRadius: this.blurRadius,
            spreadRadius: this.spreadRadius,
          ),
          child: SvgPicture.asset(
            cherrySvgPath,
            semanticsLabel: 'cherry',
            width: this.width,
          ))
    ]);
  }
}
