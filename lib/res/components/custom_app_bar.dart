import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              children: [
                TextSpan(
                    text: "Aaj",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    )
                ),
                TextSpan(text: " Tak",style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w700,
                    fontSize: 20            ))
              ]
          )

      ),
    );
  }
}
