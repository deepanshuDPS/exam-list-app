import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

void printDebug(String message) {
  if (kDebugMode) {
    print(message);
  }
}

void toLink(String link) async {
  final parsedUrl = Uri.parse(link);
  // Convert the Mailto instance into a string.
  // Use either Dart's string interpolation
  // or the toString() method.
  if (await canLaunchUrl(parsedUrl)) {
    await launchUrl(parsedUrl);
  } else {
    // TODO: Need Toast Message
    printDebug('Could not launch $parsedUrl');
  }
}

void showProgressDialog(BuildContext context, {String loadingText = ''}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.secondary)),
              if (loadingText != '')
                const SizedBox(
                  height: 16,
                ),
              if (loadingText != '')
                Text(
                  loadingText,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                )
            ],
          ),
        );
      });
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(message));
}

SnackBar makeSnackBar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
    ),
    backgroundColor: (appRed),
  );
}

Widget clickToAction(BuildContext context, String text, Function onClick) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
        foregroundColor: Theme.of(context).colorScheme.secondary),
    onPressed: () => onClick(),
    child: UnconstrainedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black),
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
              color: Colors.black,
            )
          ],
        ),
      ),
    ),
  );
}
