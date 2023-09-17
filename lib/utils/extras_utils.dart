import 'package:exam_list/utils/preferences_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
          children: [
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

bool isQueryExist(String? parent, String child){
  return parent?.toLowerCase().contains(child.toLowerCase()) == true;
}


Future<void> checkSubscriptionsStatus(
    List<String>? subscriptions, Map<String, int> subscriptionStatus) async {
  if (subscriptions == null) return;
  var subsList = await PreferencesData.getSubscriptions();
  printDebug(subsList.toString());
  printDebug(subscriptions.toString());
  if (subsList.length <= subscriptions.length) {
    // 0 means not subscribed in local
    for (var element in subscriptions) {
      subscriptionStatus[element] = subsList.contains(element) ? 2 : 0;
    }
    for (var entry in subscriptionStatus.entries) {
      if (entry.value == 0) {
        await FirebaseMessaging.instance.subscribeToTopic(entry.key);
        subscriptionStatus[entry.key] = 2;
        await PreferencesData.notifyAddNumber(entry.key);
      }
    }
    printDebug(subscriptionStatus.toString());
  } else {
    var removeSubs = Set.of(subsList).difference(Set.of(subscriptions));
    for (var adNumber in subscriptions) {
      subscriptionStatus[adNumber] = 2;
    }
    for (var topic in removeSubs) {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      subscriptionStatus[topic] = 0;
    }
    await PreferencesData.setNewSubsList(subscriptions);
  }
}
