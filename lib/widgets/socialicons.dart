import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
   List<Color>? colors;
   IconData? iconData;
   Function()? onPressed;

  SocialIcon(this.colors, this.iconData, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14.0),
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: this.colors ?? <Color>[],
            tileMode: TileMode.clamp
          ),
        ),
        child: RawMaterialButton(
          shape: CircleBorder(),

          onPressed: onPressed,
          child: Icon(iconData,color: Colors.white,),
        ),
      ),
    );
  }
}