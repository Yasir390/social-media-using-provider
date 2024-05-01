import 'package:flutter/material.dart';
import 'package:social_media/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final bool loading;


  RoundButton(
      {super.key, required this.title,
      required this.onPressed,
      this.buttonColor=AppColors.primaryColor,
      this.textColor=Colors.white,
      this.loading=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 55,
        width: double.infinity,
        child: ElevatedButton(
          onPressed:loading? null: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            )
          ),
          child:loading?const CircularProgressIndicator(color: Colors.blue,): Text(title,style: TextStyle(color: textColor),),
        ),
      ),
    );
  }
}
