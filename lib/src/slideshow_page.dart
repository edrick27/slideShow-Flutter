import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:slide_show/src/widgets/slideShow.dart'; 


class SlideShowPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SlideShow(
        puntosArriba: true,
        slides: <Widget>[
          SvgPicture.asset('assets/svg/1.svg'),
          SvgPicture.asset('assets/svg/2.svg'),
          SvgPicture.asset('assets/svg/3.svg'),
          SvgPicture.asset('assets/svg/4.svg'),
          SvgPicture.asset('assets/svg/5.svg'),
        ]
      )
    );
  }
}