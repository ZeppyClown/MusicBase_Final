import 'package:flutter/material.dart';


class AppColors {
  static const kBlueColor = Color(0xFF3C82FF);
  static const kBlackColor = Color(0xFF000000);
  static const kwhiteColor = Color(0xFFFFFFFF);
  static const kDarkblack = Color(0xFF8B959A);
}

class InkwellButtons extends StatelessWidget {
  final Image image;
  const InkwellButtons({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 170,
        height: 60,
        child: image,
      ),
    );
  }
}

class SignUpContainer extends StatelessWidget {
  final String st;
  const SignUpContainer({Key? key, required this.st}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.kBlueColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          st,
          style: const TextStyle(
            color: AppColors.kwhiteColor,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

TextSpan RichTextSpan({required String one, required String two}) {
  return TextSpan(children: [
    TextSpan(
        text: one,
        style: TextStyle(fontSize: 13, color: AppColors.kBlackColor)),
    TextSpan(
        text: two,
        style: TextStyle(
          fontSize: 13,
          color: AppColors.kBlueColor,
        )),
  ]);
}

class CustomTextField extends StatelessWidget {
  final String Lone;
  final String Htwo;
  const CustomTextField({Key? key, required this.Lone, required this.Htwo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          labelText: Lone,
          hintText: Htwo,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            width: 5,
            color: AppColors.kDarkblack,
            style: BorderStyle.solid,
          ))),
      autofocus: true,
      keyboardType: TextInputType.multiline,
    );
  }
}
