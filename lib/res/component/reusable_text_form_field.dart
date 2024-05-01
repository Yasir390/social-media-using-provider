import 'package:flutter/material.dart';

class KReUsableTextFormField extends StatelessWidget {
  const KReUsableTextFormField({super.key,
    required this.myController,
   // required this.focusNode,
    required this.onFieldSubmitted,
    required this.onValidator,
    required this.keyboardType,
    required this.hintText,
     this.obscureText=false,
     this.enable =true,
     this.autoFocus=false,
  });

  final TextEditingController myController;
 // final FocusNode focusNode;
  final FormFieldSetter onFieldSubmitted;
  final FormFieldValidator onValidator;
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final bool enable;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //textAlign: TextAlign.center,
      controller: myController,
      //    focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      validator: onValidator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enable,
      autofocus: autoFocus,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black,width: 1)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black,width: 1)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.teal,width: 1)
        ), errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red,width: 2)
        )
      ),
    );
  }
}
