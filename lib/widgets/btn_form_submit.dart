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
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
