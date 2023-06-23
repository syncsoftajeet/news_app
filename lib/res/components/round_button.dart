import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    this.buttonColor = AppColors.redColor,
    this.textColor = AppColors.whitColor,
    required this.title,
    required this.onpress,
    this.width = 100,
    this.height = 50,
    this.loading = false

  }) : super(key: key);

  final bool loading;
  final String title;
  final double height,width;
  final VoidCallback onpress;
  final Color textColor,buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: buttonColor
        ),
        child: loading ?
            const Center(child: CircularProgressIndicator(),) :
            Center(
              child: Text(title,style: TextStyle(fontSize: 15,color: textColor),),
            )
      ),
    );
  }
}
