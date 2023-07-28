import 'package:flutter/material.dart';
import 'package:exam_list/styles/app_styles.dart';

class ButtonFormSubmit extends StatelessWidget {
  final Function onClick;
  final String text;

  const ButtonFormSubmit({Key? key, required this.text, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: () {
          onClick();
        },
        child: Text(
          text,
          style: AppStyles.robotoBold().copyWith(fontSize: 18, color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22), // <-- Radius
          ),
          primary: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
