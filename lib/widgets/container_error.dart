import 'package:flutter/material.dart';
import 'package:exam_list/home/widgets/card_bg.dart';
import 'package:exam_list/styles/app_styles.dart';

class ContainerError extends StatelessWidget {
  final dynamic jsonData;
  final Function onTryAgain;

  const ContainerError(
      {Key? key, required this.jsonData, required this.onTryAgain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Center(
        child: UnconstrainedBox(
          constrainedAxis: Axis.horizontal,
          child: CardBackground(
            paddingTop: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/gif_error.gif',
                  width: 200,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    jsonData['message'],
                    style: AppStyles.robotoBlackText().copyWith(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                if (jsonData['code'] != 404 && jsonData['code'] != 204)
                  ElevatedButton(
                      onPressed: () => {onTryAgain()},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // <-- Radius
                        ),
                        primary: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Try Again',
                          style: AppStyles.robotoBold()
                              .copyWith(fontSize: 14, color: Colors.black),
                        ),
                      )),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
