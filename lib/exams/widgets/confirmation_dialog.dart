import 'package:exam_list/utils/colors.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final bool forSubscribe;
  final Function yes;

  const ConfirmationDialog(
      {Key? key, required this.forSubscribe, required this.yes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Adjust corner radius here
      ),
      title: Center(
        child: Text(
          forSubscribe ? 'Subscribe?' : 'Unsubscribe?',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            forSubscribe
                ? 'Are you sure to subscribe?'
                : 'Are you sure to unsubscribe?',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'No',
            style: TextStyle(color: appRed, fontSize: 12),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            yes();
          },
          child: const Text('Yes', style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
